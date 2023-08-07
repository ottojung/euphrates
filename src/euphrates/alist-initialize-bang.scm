;;;; Copyright (C) 2023  Otto Jung
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




(define (alist-initialize!:currently-evaluating)
  (alist-initialize!:current-setter/p))

(define (alist-initialize!:current-setters)
  (alist-initialize!/p))

;; Container for multiple return values.
(define-type9 <alist-initialize!:multiret>
  (alist-initialize!:return-multiple vals) alist-initialize!:multiret?
  (vals alist-initialize!:multiret-vals))

(define alist-initialize!:stop-signal
  'euphrates-alist-initialize!:stop-signal)

(define alist-initialize!:stop
  (case-lambda
   (() (raisu alist-initialize!:stop-signal (alist-initialize!:currently-evaluating) #f #f))
   ((value) (raisu alist-initialize!:stop-signal (alist-initialize!:currently-evaluating) #t value))))

(define (alist-initialize!:get-value name+setter)
  (define name (car name+setter))
  (define setter (cdr name+setter))
  (define threw? #f)
  (define ret-value? #t)

  (define ret
    (catchu-case
     (setter)

     ((alist-initialize!:stop-signal name* value? value)
      (set! threw? #t)
      (set! ret-value? value?)
      (set! name name*)
      value)))

  (values name ret threw? ret-value?))

(define (alist-initialize!:multi-set alist val)
  (unless (list? alist)
    (raisu 'multiple-return-values-mut-be-encoded-as-an-alist))
  (let loop ((val val) (alist alist))
    (if (null? val) alist
        (let* ((p (car val))
               (name (car p))
               (value (cdr p)))
          (loop
           (cdr val)
           (assq-set-value
            name value
            alist))))))

(define (alist-initialize!:generic-set name value alist)
  (if (alist-initialize!:multiret? value)
      (alist-initialize!:multi-set
       alist (alist-initialize!:multiret-vals value))
      (assq-set-value name value alist)))

(define-syntax alist-initialize!:run
  (syntax-rules ()
    ((_ alist setters/0)
     (let ()
       (define setters setters/0)
       (parameterize ((alist-initialize!/p setters))
         (let loop ((buf setters))
           (if (null? buf) alist
               (let ()
                 (define first (car buf))
                 (define-values (name val threw? value?)
                   (alist-initialize!:get-value first))
                 (if threw?
                     (if value?
                         (let ((ret
                                (alist-initialize!:generic-set
                                 name val alist)))
                           (set! alist ret)
                           ret)
                         alist)
                     (loop (cdr buf)))))))))))

(define-syntax alist-initialize!:makelet/static
  (syntax-rules ()
    ((_ alist setter)
     (let ()
       (define evaluated? #f)
       (define value #f)
       (define (get)
         (let ((x (assq (quote setter) alist)))
           (if x
               (cdr x)
               (raisu 'argument-not-set!d))))

       (case-lambda
        (()
         (if evaluated? value
             (let ((v (get)))
               (set! evaluated? #t)
               (set! value v)
               v)))
        ((action . args)
         (case action
           ((current) (get))
           ((recalculate) (get))
           ((or)
            (let ((x (assq (quote setter) alist)))
              (if x (cdr x) (car args))))
           (else (raisu 'unexpected-operation action)))))))))

(define-syntax alist-initialize!:prepare-bodies
  (syntax-rules (:yes :no)
    ((_ alist recalculate? :no :yes setter its-bodies) (raisu 'once-without-default))
    ((_ alist recalculate? :no :no setter its-bodies) (let () . its-bodies))

    ((_ alist recalculate? :yes :no setter its-bodies)
     (or (and (not recalculate?) (assq-or (quote setter) alist #f))
         (let () . its-bodies)))
    ((_ alist recalculate? :yes :yes setter its-bodies)
     (or (and (not recalculate?) (assq-or (quote setter) alist #f))
         (alist-initialize!:stop (let () . its-bodies))))

    ((_ alist recalculate? mapper :no setter its-bodies)
     (mapper (quote setter) alist (lambda _ . its-bodies)))
    ((_ alist recalculate? mapper :yes setter its-bodies)
     (mapper (quote setter) alist recalculate? (lambda _ (alist-initialize!:stop (let () . its-bodies)))))))

(define-syntax alist-initialize!:makelet
  (syntax-rules ()
    ((_ alist default? once? setter . ())
     (alist-initialize!:makelet/static alist setter))

    ((_ alist default? once? setter . its-bodies)
     (let ()
       (define callstack (make-hashset))
       (define evaluated? #f)
       (define value #f)
       (define (get recalculate?)
         (lambda _
           (hashset-add! callstack (quote setter))
           (let ((ret
                  (parameterize ((alist-initialize!:current-setter/p (quote setter)))
                    (alist-initialize!:prepare-bodies alist recalculate? default? once? setter its-bodies))))
             (hashset-clear! callstack)
             (set! evaluated? #t)
             (set! value ret)
             (set! alist
                   (alist-initialize!:generic-set
                    (quote setter) value alist))
             ret)))
       (define (wrap ev rec)
         (if evaluated? value
             (if (hashset-has? callstack (quote setter))
                 (rec) (ev))))
       (define (default recalculate?)
         (wrap (get recalculate?)
               (lambda _ (raisu 'infinite-recursion-during-initialization-of (quote setter)))))

       (case-lambda
        (() (default #f))
        ((action . args)
         (case action
           ((current)
            (let ((x (assq (quote setter) alist)))
              (if x
                  (cdr x)
                  (raisu 'argument-not-set!d))))
           ((recalculate)
            (set! evaluated? #f)
            (default #t))
           ((or)
            (wrap
             (lambda _
               (catchu-case
                ((get #f))
                (('infinite-recursion-during-initialization-of name)
                 (hashset-delete! callstack (quote setter))
                 (set! evaluated? #f)
                 (car args))))
             (lambda _ (car args))))
           (else (raisu 'unexpected-operation action)))))))))

(define-syntax alist-initialize!:get-setters/aux
  (syntax-rules ()
    ((_ alist
        default?
        once?
        ()
        buf2)
     (reverse buf2))

    ((_ alist
        default?
        once?
        buf1
        buf2)
     (letrec buf1
       (reverse buf2)))

    ((_ alist
        default?
        once?
        buf1
        buf2
        (setter . its-bodies)
        . rest-setters)
     (alist-initialize!:get-setters/aux
      alist
      default?
      once?
      ((setter (alist-initialize!:makelet alist default? once? setter . its-bodies)) . buf1)
      (cons (cons (quote setter) setter) buf2)
      . rest-setters))))

(define-syntax alist-initialize!:get-setters
  (syntax-rules (:default :once :map)
    ((_ alist-name :default :once . setters)
     (alist-initialize!:get-setters/aux
      alist-name
      :yes ;; default flag
      :yes ;; once flag
      ()
      '()
      . setters))

    ((_ alist-name :map mapper :once . setters)
     (alist-initialize!:get-setters/aux
      alist-name
      mapper ;; default flag
      :yes ;; once flag
      ()
      '()
      . setters))

    ((_ alist-name :default . setters)
     (alist-initialize!:get-setters/aux
      alist-name
      :yes ;; default flag
      :no ;; once flag
      ()
      '()
      . setters))

    ((_ alist-name :map mapper . setters)
     (alist-initialize!:get-setters/aux
      alist-name
      mapper ;; default flag
      :no ;; once flag
      ()
      '()
      . setters))

    ((_ alist-name . setters)
     (alist-initialize!:get-setters/aux
      alist-name
      :no ;; default flag
      :no ;; once flag
      ()
      '()
      . setters))))

(define-syntax alist-initialize!
  (syntax-rules ()
    ((_ alist-name . setters)
     (let ()
       (define buf2rev (alist-initialize!:get-setters alist-name . setters))
       (alist-initialize!:run alist-name buf2rev)))))
