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
  (define-module (euphrates monad-make-no-fin)
    :export (monad-make/no-fin)
    :use-module ((euphrates monadfinobj) :select (monadfinobj?))
    :use-module ((euphrates monadobj) :select (monadobj-constructor)))))



(define (monad-make/no-fin proc)
  (define uses-continuations? #t)
  (define handles-fin? #f)
  (monadobj-constructor
   (lambda (monad-input)
     (if (monadfinobj? monad-input) monad-input
         (proc monad-input)))
   uses-continuations? handles-fin?))
