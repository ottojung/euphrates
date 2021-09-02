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

%var stack-make
%var stack-empty?
%var stack-push!
%var stack-pop!
%var stack-peek
%var stack-discard!
%var stack->list
%var stack-unload!

%use (stack stack? stack-lst set-stack-lst!) "./stack-obj.scm"
%use (raisu) "./raisu.scm"

(define (stack-make)
  (stack '()))

(define (stack-empty? S)
  (null? (stack-lst S)))

(define (stack-push! S value)
  (set-stack-lst! S (cons value (stack-lst S))))

(define (stack-pop! S)
  (when (stack-empty? S)
    (raisu 'pop-on-empty-stack))
  (let ((top (car (stack-lst S))))
    (set-stack-lst! S (cdr (stack-lst S)))
    top))

(define (stack-peek S)
  (when (stack-empty? S)
    (raisu 'peek-on-empty-stack))
  (car (stack-lst S)))

(define (stack-discard! S)
  (when (stack-empty? S)
    (raisu 'discard-on-empty-stack))
  (set-stack-lst! S (cdr (stack-lst S))))

(define (stack->list S)
  (stack-lst S))

(define (stack-unload! S)
  (let ((lst (stack-lst S)))
    (set-stack-lst! S '())
    lst))
