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

(cond-expand
 (guile
  (define-module (euphrates monad-do)
    :export (monad-do monad-do/generic)
    :use-module ((euphrates memconst) :select (memconst))
    :use-module ((euphrates monad-apply) :select (monad-apply))
    :use-module ((euphrates monad-current-p) :select (monad-current/p))
    :use-module ((euphrates monadobj) :select (monadobj?))
    :use-module ((euphrates monadstateobj) :select (monadstateobj monadstateobj-cont monadstateobj-lval monadstateobj-qvar))
    :use-module ((euphrates raisu) :select (raisu))
    :use-module ((euphrates range) :select (range)))))



(define (monad-do/rethunkify m)
  (define thunk (monadstateobj-lval m))
  (define qvar (monadstateobj-qvar m))
  (define len (if (list? qvar) (length qvar) 1))

  (cond
   ((list? thunk) thunk)
   ((procedure? thunk)
    (let ((result (memconst
                   (let ((ret (thunk)))
                     (unless (= len (length ret))
                       (raisu 'incorrect-number-of-arguments-returned-by-monad (length ret) len))
                     ret))))
      (map
       (lambda (i)
         (memconst
          (list-ref (result) i)))
       (range len))))
   (else
    (raisu 'bad-thunk-type thunk))))

(define (monad-do/continue m)
  (apply (monadstateobj-cont m) (monad-do/rethunkify m)))

(define-syntax monad-do/generic
  (syntax-rules ()
    ((_ (var val qtags))
     (let ((f (monad-current/p)))
       (cond
        ((not f)
         (raisu 'no-current-monad-specified f))
        ((not (monadobj? f))
         (raisu 'bad-monad-type f)))

       (monad-do/generic (f var val qtags))))
    ((_ (f var val qtags))
     (call-with-current-continuation
      (lambda (cont)
        (monad-do/generic (f var val qtags) cont))))
    ((_ (f var val qtags) cont)
     (let ((arg (monadstateobj
                 (memconst (call-with-values (lambda _ val) list))
                 cont
                 (let* ((qvar0 (quote var))
                        (qvar (if (equal? qvar0 (quote #f)) #f qvar0)))
                   qvar)
                 (quote val)
                 qtags)))
       (monad-do/continue (monad-apply f arg))))))

(define-syntax monad-do
  (syntax-rules ()
    ((_ val . tags)
     (monad-do/generic (#f val (list . tags))))))
