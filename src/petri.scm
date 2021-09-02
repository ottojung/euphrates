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
%var petri-run-list

%use (hashmap) "./hashmap.scm"
%use (hashmap-ref hashmap-set! multi-alist->hashmap hashmap-clear!) "./ihashmap.scm"
%use (range) "./range.scm"
%use (list-or-map) "./list-or-map.scm"
%use (catch-any) "./catch-any.scm"
%use (cartesian-product/g) "./cartesian-product-g.scm"
%use (list-map/flatten) "./list-map-flatten.scm"

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
;;      (list (cons 'tr-name-1 (("arg-a" "arg-b")
;;                              ("arg-a" "arg-b2")))
;;            (cons 'tr-name-2 (("arg-a" "arg-b" "arg-c"))))
;;
;; `table' is a hashmap of "tr-name" -> "transition procedure"
(define (petri-make-transformer)
  ;; Hashmap of (cons tr-name arg-index) -> (listof args-at-arg-index)
  ;;     and of (cons tr-name 'arity) -> arity of tr-name
  (define todos-work-table (hashmap))

  ;; List of unique names in the queue
  (define names-queue '())
  (define (get-names-queue)
    names-queue) ;; TODO: inline
  (define (add-name-to-names-queue tr-name)
    (set! names-queue (cons tr-name names-queue)))

  (define (make-arity-key tr-name)
    (cons tr-name 'arity))

  (define (set-transition-arity! H tr-name arity)
    (define key (make-arity-key tr-name))

    (unless (hashmap-ref H key #f)
      (add-name-to-names-queue tr-name))

    (hashmap-set! H key arity))

  ;; Appends each argument that is not #f
  (define (append-argumets-to-transition H tr-name args)
    (let loop ((args args) (i 0))
      (if (null? args)
          (set-transition-arity! H tr-name i)
          (let* ((arg (car args))
                 (key (cons tr-name i)))
            (when arg
              (hashmap-set! H key (cons arg (hashmap-ref H key '()))))
            (loop (cdr args) (+ 1 i))))))

  (define (add-indexed-args-to-hashmap H queue)
    (for-each
     (lambda (p)
       (define tr-name (car p))
       (define args (cdr p))
       (append-argumets-to-transition H tr-name args))
     queue))

  (define (make-products H)
    (define (make-one tr-name)
      (define arity (hashmap-ref H (make-arity-key tr-name) #f))

      (define (construct)
        (define R (range arity))
        (define lists (map (lambda (i) (hashmap-ref H (cons tr-name i) '())) R))
        (if (list-or-map null? lists) #f
            (cartesian-product/g lists)))

      (define args (if (= 0 arity) '(()) (construct)))
      (and args (cons tr-name args)))

    (map make-one (get-names-queue)))

  (define (get-todos H queue)
    (add-indexed-args-to-hashmap H queue)
    (filter identity (make-products H)))

  (lambda (global-queue)
    (hashmap-clear! todos-work-table)
    (set! names-queue '())

    (get-todos todos-work-table global-queue)))

(define (petri-run-cycle error-handler names-table todos)

  (define (run-transition tr-name transition args)
    (catch-any
     (lambda _
       (apply transition args))
     (lambda errors
       (error-handler 'runtime-error tr-name args errors))))

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

;;
;; Example `list-of-transitions':
;;   (list (cons 'hello (lambda () (display "Hello\n") (petri-push 'bye "Robert")))
;;         (cons 'bye (lambda (name) (display "Bye ") (display name) (display "!\n"))))
;; First transtion must receive 0 arguments.
(define (petri-run-list error-handler list-of-transitions)
  (define names-table (multi-alist->hashmap list-of-transitions))
  (define global-queue (list (cons (car (car list-of-transitions)) '())))

  (define (reset-queue!)
    (set! global-queue '()))

  (define (push tr-name args)
    (if (hashmap-ref names-table tr-name #f)
        (set! global-queue (cons (cons tr-name args) global-queue))
        (error-handler 'bad-key tr-name args)))

  (define transformer (petri-make-transformer))

  (parameterize ((petri-push/p push))
    (let loop ()
      (unless (null? global-queue)
        (let ((q global-queue))
          (reset-queue!)

          (define todos (transformer q))
          (debug "TODOS: ~s" todos)

          ;; fire the network
          (petri-run-cycle error-handler names-table todos)

          (loop))))))

