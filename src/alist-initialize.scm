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

%var alist-initialize
%var alist-initialize:stop

%use (alist-initialize/p) "./alist-initialize-p.scm"
%use (assq-set-value) "./assq-set-value.scm"
%use (catchu-case) "./catchu-case.scm"
%use (define-type9) "./define-type9.scm"
%use (hashset-add! hashset-delete! hashset-has? make-hashset) "./hashset.scm"
%use (raisu) "./raisu.scm"

(define-type9 <alist-initialize:pstruct>
  (alist-initialize:pstruct-ctr setters) alist-initialize:pstruct?
  (setters alist-initialize:pstruct-setters)
  )

(define alist-initialize:stop-signal (gensym))

(define alist-initialize:stop
  (case-lambda
   (() (raisu alist-initialize:stop-signal #f #f))
   ((value) (raisu alist-initialize:stop-signal #t value))))

(define (alist-initialize:get-value setter)
  (define threw? #f)
  (define ret-value? #t)

  (define ret
    (catchu-case
     (setter)

     ((alist-initialize:stop-signal value? value)
      (set! threw? #t)
      (set! ret-value? value?)
      value)))

  (values ret threw? ret-value?))

(define-syntax alist-initialize:run
  (syntax-rules ()
    ((_ alist buf/0)
     (let loop ((buf (reverse buf/0)))
       (if (null? buf) alist
           (let ()
             (define first (car buf))
             (define name (car first))
             (define setter (cdr first))
             (define-values (val threw? value?)
               (alist-initialize:get-value setter))
             (when value?
               (set! alist (assq-set-value
                            name val
                            alist)))

             (if threw?
                 alist
                 (loop (cdr buf)))))))))

(define-syntax alist-initialize:makelet
  (syntax-rules ()
    ((_ alist callstack setter . ())
     (let ()
       (define evaluated? #f)
       (define value #f)
       (define (get)
         (let ((x (assq (quote setter) alist)))
           (if x
               (cdr x)
               (raisu 'argument-not-initialized))))

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
                  (raisu 'argument-not-initialized))))
           ((or)
            (wrap
             (lambda _
               (catchu-case
                (get)
                (('infinite-recursion-during-initialization-of name)
                 (hashset-delete! callstack (quote setter))
                 (car args))))
             (lambda _ (car args))))
           (else (raisu 'unexpected-operation action)))))))))

(define-syntax alist-initialize:iterate
  (syntax-rules ()
    ((_ alist
        callstack
        buf1
        buf2)
     (let ((callstack (make-hashset)))
       (letrec buf1
         (define pstruct
           (alist-initialize:pstruct-ctr buf2))
         (parameterize ((alist-initialize/p pstruct))
           (alist-initialize:run alist buf2)))))

    ((_ alist
        callstack
        buf1
        buf2
        (setter . its-bodies)
        . rest-setters)
     (alist-initialize:iterate
      alist
      callstack
      ((setter (alist-initialize:makelet alist callstack setter . its-bodies)) . buf1)
      (cons (cons (quote setter) setter) buf2)
      . rest-setters))))

(define-syntax alist-initialize
  (syntax-rules ()
    ((_ alist-name . setters)
     (alist-initialize:iterate
      alist-name
      callstack
      ()
      '()
      . setters))))
