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

%var monad-maybe

%use (monad-make/simple) "./monad-make-simple.scm"
%use (monadstate-arg monadstate-cret monadstate-ret) "./monadstate.scm"

(define (monad-maybe predicate)
  (monad-make/simple
   (monad-input)
   (call-with-values
       (lambda _ (monadstate-arg monad-input))
     (lambda args
       (if (apply predicate args)
           (monadstate-cret monad-input args identity)
           (monadstate-ret  monad-input args))))))
