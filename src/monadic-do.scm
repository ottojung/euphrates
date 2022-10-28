;;;; Copyright (C) 2020, 2021, 2022  Otto Jung
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

%var monadic-do
%var monadic-do/generic

%use (memconst) "./memconst.scm"
%use (monad-current/p) "./monad-current-p.scm"
%use (monadstate monadstate-cont monadstate-lval monadstate-qvar) "./monadstate.scm"
%use (raisu) "./raisu.scm"
%use (range) "./range.scm"

(define (monadic-do/rethunkify m)
  (define thunk (monadstate-lval m))
  (define qvar (monadstate-qvar m))
  (define len (if (list? qvar) (length qvar) 1))

  (cond
   ((list? thunk) thunk)
   ((procedure? thunk)
    (let ((result (memconst (thunk))))
      (map
       (lambda (i)
         (memconst
          (list-ref (result) i)))
       (range len))))
   (else
    (raisu 'bad-thunk-type thunk))))

(define (monadic-do/continue m)
  (apply (monadstate-cont m) (monadic-do/rethunkify m)))

(define-syntax monadic-do/generic
  (syntax-rules ()
    ((_ (f var val qtags) cont)
     (let ((arg
            (monadstate
             (memconst (call-with-values (lambda _ val) list))
             cont
             (let* ((qvar0 (quote var))
                    (qvar (if (equal? qvar0 (quote #f)) #f qvar0)))
               qvar)
             (quote val)
             qtags)))
       (monadic-do/continue (f arg))))))

(define-syntax monadic-do
  (syntax-rules ()
    ((_ (var val qtags) cont)
     (let ((f (monad-current/p)))
       (monadic-do/generic (f var val qtags) cont)))
    ((_ (var val qtags))
     (call-with-current-continuation
      (lambda (cont)
        (let ((f (monad-current/p)))
          (monadic-do/generic (f var val qtags) cont)))))
    ((_ (val qtags) cont)
     (let ((f (monad-current/p)))
       (monadic-do/generic (f #f val qtags) cont)))
    ((_ (val qtags))
     (call-with-current-continuation
      (lambda (cont)
        (let ((f (monad-current/p)))
          (monadic-do/generic (f #f val qtags) cont)))))))
