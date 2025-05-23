;;;; Copyright (C) 2021, 2022, 2024, 2023  Otto Jung
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




(define stack? stack-predicate)

(define (stack-make)
  (stack-constructor '()))

(define (stack-empty? S)
  (null? (stack-lst S)))

(define (stack-has? S x)
  (let ((lst (stack-lst S)))
    (if (member x S) #t #f)))

(define (stack-push! S value)
  (set-stack-lst! S (cons value (stack-lst S))))

(define stack-pop!
  (case-lambda
   ((S)
    (when (stack-empty? S)
      (raisu 'pop-on-empty-stack))
    (let ((top (car (stack-lst S))))
      (set-stack-lst! S (cdr (stack-lst S)))
      top))
   ((S default)
    (if (null? (stack-lst S)) default
        (let ((top (car (stack-lst S))))
          (set-stack-lst! S (cdr (stack-lst S)))
          top)))))

(define stack-peek
  (case-lambda
   ((S)
    (when (stack-empty? S)
      (raisu 'peek-on-empty-stack))
    (car (stack-lst S)))
   ((S default)
    (if (null? (stack-lst S)) default
        (car (stack-lst S))))))

(define (stack-discard! S)
  (unless (stack-empty? S)
    (set-stack-lst! S (cdr (stack-lst S)))))

(define (stack->list S)
  (stack-lst S))

(define (list->stack L)
  (stack-constructor L))

(define (stack-unload! S)
  (let ((lst (stack-lst S)))
    (set-stack-lst! S '())
    lst))

(define (stack-copy S)
  (list->stack (stack->list S)))

(define (stack-pop-multiple! stack n)
  (let loop ((n n) (buf '()))
    (if (<= n 0) buf
        (let ()
          (define top (stack-pop! stack))
          (loop (- n 1) (cons top buf))))))
