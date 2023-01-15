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

%var alist-set!
%var alist-set!:stop

%use (alist-set!/p) "./alist-set-bang-p.scm"
%use (assq-set-value) "./assq-set-value.scm"
%use (catchu-case) "./catchu-case.scm"
%use (define-type9) "./define-type9.scm"
%use (hashset-add! hashset-delete! hashset-has? make-hashset) "./hashset.scm"
%use (raisu) "./raisu.scm"

(define-type9 <alist-set!:pstruct>
  (alist-set!:pstruct-ctr setters) alist-set!:pstruct?
  (setters alist-set!:pstruct-setters)
  )

(define alist-set!:stop-signal (gensym))

(define alist-set!:stop
  (case-lambda
   (() (raisu alist-set!:stop-signal #f #f))
   ((value) (raisu alist-set!:stop-signal #t value))))

(define (alist-set!:get-value setter)
  (define threw? #f)
  (define ret-value? #t)

  (define ret
    (catchu-case
     (setter)

     ((alist-set!:stop-signal value? value)
      (set! threw? #t)
      (set! ret-value? value?)
      value)))

  (values ret threw? ret-value?))

(define-syntax alist-set!:run
  (syntax-rules ()
    ((_ alist buf/0)
     (let loop ((buf buf/0))
       (if (null? buf) alist
           (let ()
             (define first (car buf))
             (define name (car first))
             (define setter (cdr first))
             (define-values (val threw? value?)
               (alist-set!:get-value setter))
             (when value?
               (set! alist (assq-set-value
                            name val
                            alist)))

             (if threw?
                 alist
                 (loop (cdr buf)))))))))

(define-syntax alist-set!:makelet
  (syntax-rules ()
    ((_ alist callstack setter . ())
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
           (else (raisu 'unexpected-operation action)))))))

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

(define-syntax alist-set!:iterate
  (syntax-rules ()
    ((_ alist
        callstack
        buf1
        buf2)
     (let ((callstack (make-hashset)))
       (letrec buf1
         (define buf2rev (reverse buf2))
         (define pstruct
           (alist-set!:pstruct-ctr buf2rev))
         (parameterize ((alist-set!/p pstruct))
           (alist-set!:run alist buf2rev)
           buf2rev))))

    ((_ alist
        callstack
        buf1
        buf2
        (setter . its-bodies)
        . rest-setters)
     (alist-set!:iterate
      alist
      callstack
      ((setter (alist-set!:makelet alist callstack setter . its-bodies)) . buf1)
      (cons (cons (quote setter) setter) buf2)
      . rest-setters))))

(define-syntax alist-set!
  (syntax-rules ()
    ((_ alist-name . setters)
     (alist-set!:iterate
      alist-name
      callstack
      ()
      '()
      . setters))))
