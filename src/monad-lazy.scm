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

%var monad-lazy

%use (dynamic-thread-async) "./dynamic-thread-async.scm"
%use (monad-make/simple) "./monad-make-simple.scm"
%use (monad-arg monad-ret/thunk) "./monad.scm"
%use (monadstate-lval monadstate-qtags) "./monadstate.scm"

;; Provides lazy evaluation, with "async" feature
(define monad-lazy
  (monad-make/simple
   (monad-input)
   (define result
     (if (memq 'async (monadstate-qtags monad-input))
         (dynamic-thread-async
          (call-with-values
              (lambda _ (monad-arg monad-input))
            list))
         (monadstate-lval monad-input)))
   (monad-ret/thunk monad-input result)))
