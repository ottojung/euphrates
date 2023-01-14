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
%use (memconst) "./memconst.scm"
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

(define (alist-initialize:run initial-alist/0 buf/0)
  (let loop ((buf (reverse buf/0)) (initial-alist initial-alist/0))
    (if (null? buf) initial-alist
        (let ()
          (define first (car buf))
          (define name (car first))
          (define setter (cdr first))
          (define-values (val threw? value?)
            (alist-initialize:get-value setter))
          (define new-alist
            (if value?
                (assq-set-value
                 name val
                 initial-alist)
                initial-alist))

          (if threw?
              new-alist
              (loop (cdr buf) new-alist))))))

(define-syntax alist-initialize:makelet
  (syntax-rules ()
    ((_ initial-alist setter . ())
     (memconst
      (let ((x (assq (quote setter) initial-alist)))
        (unless x
          (raisu 'argument-not-initialized))
        (cdr x))))
    ((_ initial-alist setter . its-bodies)
     (memconst (let () . its-bodies)))))

(define-syntax alist-initialize:iterate
  (syntax-rules ()
    ((_ initial-alist
        buf1
        buf2)
     (letrec buf1
       (define pstruct
         (alist-initialize:pstruct-ctr buf2))
       (parameterize ((alist-initialize/p pstruct))
         (alist-initialize:run initial-alist buf2))))

    ((_ initial-alist
        buf1
        buf2
        (setter . its-bodies)
        . rest-setters)
     (alist-initialize:iterate
      initial-alist
      ((setter (alist-initialize:makelet initial-alist setter . its-bodies)) . buf1)
      (cons (cons (quote setter) setter) buf2)
      . rest-setters))))

(define-syntax alist-initialize
  (syntax-rules ()
    ((_ initial-alist/0 . setters)
     (let ((initial-alist initial-alist/0))
       (alist-initialize:iterate
        initial-alist
        ()
        '()
        . setters)))))
