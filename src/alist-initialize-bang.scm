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

%run guile

%var alist-initialize!
%var alist-initialize!:stop
%var alist-initialize!:return-multiple
%var alist-initialize!:get-setters
%var alist-initialize!:makelet/static
%var alist-initialize!:run

%use (alist-initialize!/p) "./alist-initialize-bang-p.scm"
%use (assq-set-value) "./assq-set-value.scm"
%use (catchu-case) "./catchu-case.scm"
%use (define-type9) "./define-type9.scm"
%use (hashset-add! hashset-delete! hashset-has? make-hashset) "./hashset.scm"
%use (raisu) "./raisu.scm"

;; Container for multiple return values.
(define-type9 <alist-initialize!:multiret>
  (alist-initialize!:return-multiple vals) alist-initialize!:multiret?
  (vals alist-initialize!:multiret-vals))

(define alist-initialize!:stop-signal (gensym))

(define alist-initialize!:stop
  (case-lambda
   (() (raisu alist-initialize!:stop-signal #f #f))
   ((value) (raisu alist-initialize!:stop-signal #t value))))

(define (alist-initialize!:get-value setter)
  (define threw? #f)
  (define ret-value? #t)

  (define ret
    (catchu-case
     (setter)

     ((alist-initialize!:stop-signal value? value)
      (set! threw? #t)
      (set! ret-value? value?)
      value)))

  (values ret threw? ret-value?))

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
                 (define name (car first))
                 (define setter (cdr first))
                 (define-values (val threw? value?)
                   (alist-initialize!:get-value setter))
                 (when value?
                   (set! alist
                         (if (alist-initialize!:multiret? val)
                             (alist-initialize!:multi-set
                              alist (alist-initialize!:multiret-vals val))
                             (assq-set-value
                              name val
                              alist))))

                 (if threw?
                     alist
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
           ((or)
            (let ((x (assq (quote setter) alist)))
              (if x (cdr x) (car args))))
           (else (raisu 'unexpected-operation action)))))))))

(define-syntax alist-initialize!:makelet
  (syntax-rules ()
    ((_ alist callstack setter . ())
     (alist-initialize!:makelet/static alist setter))

    ((_ alist callstack setter . its-bodies)
     (let ()
       (define evaluated? #f)
       (define value #f)
       (define (get)
         (hashset-add! callstack (quote setter))
         (let ((ret (let () . its-bodies)))
           (set! evaluated? #t)
           (set! value ret)
           ret))
       (define (wrap ev rec)
         (if evaluated? value
             (if (hashset-has? callstack (quote setter))
                 (rec) (ev))))

       (case-lambda
        (() (wrap get (lambda _ (raisu 'infinite-recursion-during-initialization-of (quote setter)))))
        ((action . args)
         (case action
           ((current)
            (let ((x (assq (quote setter) alist)))
              (if x
                  (cdr x)
                  (raisu 'argument-not-set!d))))
           ((or)
            (wrap
             (lambda _
               (catchu-case
                (get)
                (('infinite-recursion-during-initialization-of name)
                 (hashset-delete! callstack (quote setter))
                 (set! evaluated? #f)
                 (car args))))
             (lambda _ (car args))))
           (else (raisu 'unexpected-operation action)))))))))

(define-syntax alist-initialize!:get-setters/aux
  (syntax-rules ()
    ((_ alist
        callstack
        ()
        buf2)
     (reverse buf2))

    ((_ alist
        callstack
        buf1
        buf2)
     (let ((callstack (make-hashset)))
       (letrec buf1
         (reverse buf2))))

    ((_ alist
        callstack
        buf1
        buf2
        (setter . its-bodies)
        . rest-setters)
     (alist-initialize!:get-setters/aux
      alist
      callstack
      ((setter (alist-initialize!:makelet alist callstack setter . its-bodies)) . buf1)
      (cons (cons (quote setter) setter) buf2)
      . rest-setters))))

(define-syntax alist-initialize!:get-setters
  (syntax-rules ()
    ((_ alist-name . setters)
     (alist-initialize!:get-setters/aux
      alist-name
      callstack
      ()
      '()
      . setters))))

(define-syntax alist-initialize!
  (syntax-rules ()
    ((_ alist-name . setters)
     (let ()
       (define buf2rev (alist-initialize!:get-setters alist-name . setters))
       (alist-initialize!:run alist-name buf2rev)))))
