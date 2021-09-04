;;;; Copyright (C) 2021  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

%run guile

;; Inspired from guile-petri library of Julien Lepiller:
;; https://tyreunom.frama.io/guile-petri/documentation/The-Echo-Server.html

%var petri-push
%var petri-run

%use (hashmap) "./hashmap.scm"
%use (hashmap-ref hashmap-set! multi-alist->hashmap hashmap->alist hashmap-clear!) "./ihashmap.scm"
%use (make-hashset hashset-add! hashset-ref hashset-clear!) "./ihashset.scm"
%use (range) "./range.scm"
%use (list-or-map) "./list-or-map.scm"
%use (catch-any) "./catch-any.scm"
%use (cartesian-product/g) "./cartesian-product-g.scm"
%use (list-map/flatten) "./list-map-flatten.scm"
%use (list-deduplicate) "./list-deduplicate.scm"
%use (petri-net-obj petri-net-obj? petri-net-obj-transitions petri-net-obj-queue petri-net-obj-critical petri-net-obj-finished? set-petri-net-obj-finished?!) "./petri-net-obj.scm"
%use (raisu) "./raisu.scm"
%use (stack-make stack-unload! stack-push! stack-pop!) "./stack.scm"
%use (with-critical) "./with-critical.scm"
%use (dynamic-thread-yield) "./dynamic-thread-yield.scm"
%use (dynamic-thread-critical-make) "./dynamic-thread-critical-make.scm"
%use (dynamic-thread-async) "./dynamic-thread-async.scm"
%use (curry-if) "./curry-if.scm"

%use (debug) "./debug.scm"

(define petri-push/p
  (make-parameter #f))

;; Arguments that are #f will be ignored.
;; So only truthy tokens are ever received by the transitions.
(define (petri-push tr-name . args)
  ((petri-push/p) tr-name args))

;; TODO: allow restarting the last cycle
;; TODO: allow restarting the whole thing
;; TODO: allow preemptive exiting
;; FIXME: throw error on bad arity push, not call
;; TODO: use multithreading
;; TODO: delay errors to their own cycles

;; Transforms petri global-queue into list of things to evalutate (the "todos").
;; So a list like:
;;      (list (cons 'tr-name-1 "arg-a" "arg-b")
;;            (cons 'tr-name-2 "arg-a" "arg-b" "arg-c")
;;            (cons 'tr-name-1 #f      "arg-b2"))
;;  into the list:
;;      (list (cons (cons 'tr-name-1 2) (("arg-a" "arg-b")
;;                                       ("arg-a" "arg-b2")))
;;            (cons (cons 'tr-name-2 3) (("arg-a" "arg-b" "arg-c"))))
;;
;; `defined-names' is a hashset of tr-names that are defined in the current network.
(define (petri-make-transformer defined-names options)
  ;; Hashmap of (cons (cons tr-name arg-arity) arg-index) -> (listof args-at-arg-index)
  (define todos-work-table (hashmap))

  ;; Deduplication for todos elements
  (define deduplicate?
    (assoc 'deduplicate options))
  (define deduplication-procedure
    (if deduplicate? list-deduplicate identity))

  ;; List of unique names in the queue. A subset of `defined-names'
  (define names-queue '())
  (define names-hashset (make-hashset))
  (define (add-name-to-names-queue! name)
    (unless (hashset-ref names-hashset name)
      (hashset-add! names-hashset name)
      (set! names-queue (cons name names-queue))))

  ;; Appends each argument that is not #f
  (define (append-argumets-to-transition H tr-name args)
    (define arity (length args))
    (define name (cons tr-name arity))

    (when (hashset-ref defined-names name)
      (add-name-to-names-queue! name)
      (let loop ((args args) (i 0))
        (unless (null? args)
          (let* ((arg (car args)))
            (when arg
              (let ((key (cons name i)))
                (hashmap-set! H key (cons arg (hashmap-ref H key '())))))
            (loop (cdr args) (+ 1 i)))))))

  (define (add-indexed-args-to-hashmap H queue)
    (for-each
     (lambda (p)
       (define tr-name (car p))
       (define args (cdr p))
       (append-argumets-to-transition H tr-name args))
     queue))

  (define (make-products H)
    (define (make-one name)
      (define tr-name (car name))
      (define arity (cdr name))

      (define (construct)
        (define R (range arity))
        (define lists/dupl (map (lambda (i) (hashmap-ref H (cons name i) '())) R))
        (define lists (map deduplication-procedure lists/dupl))
        (if (list-or-map null? lists) #f
            (cartesian-product/g lists)))

      (define args (if (= 0 arity) '(()) (construct)))
      (and args (cons name args)))

    (map make-one names-queue))

  (define (get-todos H queue)
    (add-indexed-args-to-hashmap H queue)
    (filter identity (make-products H)))

  (lambda (global-queue)
    (hashmap-clear! todos-work-table)
    (hashset-clear! names-hashset)
    (set! names-queue '())

    (get-todos todos-work-table global-queue)))

(define (petri-run-cycle error-handler names-table todos)

  (define (run-transition tr-name transition args)
    (cons tr-name
          (cons args
                (dynamic-thread-async
                 (apply transition args)))))

  (define (run-todos todos)
    (list-map/flatten
     (lambda (p)
       (define tr-name (car p))
       (define multi-args (cdr p))
       (define transitions (hashmap-ref names-table tr-name '()))
       (list-map/flatten
        (lambda (transition)
          (map
           (lambda (args)
             (run-transition tr-name transition args))
           multi-args))
        transitions))
     todos))

  (define ret (run-todos todos))

  ret)

(define (petri-collect-errors futures)
  (filter
   identity
   (map
    (lambda (future/named)
      (define name (car future/named))
      (define args (cadr future/named))
      (define future (cddr future/named))
      (future 'wait/no-throw)
      (and (eq? 'fail (future 'status))
           (list name args (future 'results))))
    futures)))

(define (petri-cycle-network error-handler transformer queue net)
  ;; collect todos
  (define todos
    (transformer queue))

  ;; fire the transitions
  (define futures
    (petri-run-cycle error-handler (petri-net-obj-transitions net) todos))

  ;; wait until all of them are finished
  (define errors
    (petri-collect-errors futures))

  ;; handle errors
  (unless (null? errors)
    (catch-any
     (lambda _
       (error-handler 'runtime-errors errors))
     (lambda handling-errors
       (raisu 'error-handling-failed handling-errors queue errors))))

  (values))

(define (petri-loop-network error-handler options unload! net)
  (define names-set (make-hashset (map car (hashmap->alist (petri-net-obj-transitions net)))))
  (define transformer (petri-make-transformer names-set options))
  (let loop ()
    (let ((q (unload!)))
      (unless (null? q)
        (petri-cycle-network error-handler transformer q net)
        (loop)))))

(define (petri-start-network error-handler options net)
  (define (unload!)
    (with-critical
     (petri-net-obj-critical net)
     (stack-unload! (petri-net-obj-queue net))))

  (with-critical
   (petri-net-obj-critical net)
   (set-petri-net-obj-finished?! net #f))

  (petri-loop-network error-handler options unload! net)

  (with-critical
   (petri-net-obj-critical net)
   (set-petri-net-obj-finished?! net #t)))

(define (petri-run/optioned start-transition-name options error-handler list-or-network)
  (define list-of-petri-networks ((curry-if petri-net-obj? list) list-or-network))
  (define networks-futures (stack-make))
  (define global-critical (dynamic-thread-critical-make))

  (define (restart net)
    (with-critical
     global-critical
     (stack-push!
      networks-futures
      (cons net
            (dynamic-thread-async
             (petri-start-network error-handler options net))))))

  (define (check-finished net)
    (and (petri-net-obj-finished? net)
         (begin
           (set-petri-net-obj-finished?! net #f)
           #t)))

  (define (push tr-name args)
    (for-each
     (lambda (net)
       (when (with-critical
              (petri-net-obj-critical net)
              (stack-push! (petri-net-obj-queue net)
                           (cons tr-name args))
              (check-finished net))
         (restart net)))
     list-of-petri-networks))

  (let* ((start-transition-name* (cons start-transition-name 0))
         (start-transitions
          (filter identity
                  (map (lambda (net)
                         (hashmap-ref (petri-net-obj-transitions net) start-transition-name* #f))
                       list-of-petri-networks))))
    (when (null? start-transitions)
      (raisu 'start-transition-does-not-exist-in-any-of-the-networks start-transition-name)))

  (push start-transition-name '())

  (for-each
   (lambda (net)
     (parameterize ((petri-push/p push))
       (restart net)))
   list-of-petri-networks)

  (let loop ()
    (define future/named
      (with-critical global-critical (stack-pop! networks-futures #f)))
    (when future/named
      (let ((net (car future/named))
            (future (cdr future/named)))
        (future 'wait/no-throw)
        (when (eq? 'fail (future 'status))
          (catch-any
           (lambda _
             (error-handler 'network-failed net (future 'results)))
           (lambda errors
             (display "Petri run failed on handling 'network-failed error. Exceptions: " (current-error-port))
             (display errors (current-error-port))
             (newline (current-error-port)))))
        (loop)))))

(define petri-run
  (case-lambda
   ((start-transition-name error-handler list-of-petri-networks)
    (petri-run/optioned start-transition-name '()  error-handler list-of-petri-networks))
   ((start-transition-name options error-handler list-of-petri-networks)
    (petri-run/optioned start-transition-name options error-handler list-of-petri-networks))))
