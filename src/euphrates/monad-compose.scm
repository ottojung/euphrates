;;;; Copyright (C) 2022  Otto Jung
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
  (define-module (euphrates monad-compose)
    :export (monad-compose)
    :use-module ((euphrates monadobj) :select (monadobj-constructor monadobj-handles-fin? monadobj-procedure monadobj-uses-continuations? monadobj?))
    :use-module ((euphrates raisu) :select (raisu)))))



(define (monad-compose left right)
  (unless (monadobj? left)
    (raisu 'monad-compose-argument-is-not-a-monad 'left left))
  (unless (monadobj? right)
    (raisu 'monad-compose-argument-is-not-a-monad 'right right))

  (monadobj-constructor
   (compose (monadobj-procedure left)
            (monadobj-procedure right))
   (or (monadobj-uses-continuations? left)
       (monadobj-uses-continuations? right))
   (or (monadobj-handles-fin? left)
       (monadobj-handles-fin? right))))
