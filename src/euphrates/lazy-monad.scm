;;;; Copyright (C) 2020, 2021, 2022, 2023  Otto Jung
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




;; Provides lazy evaluation, with "async" feature
(define lazy-monad
  (monad-make/no-cont/no-fin
   (lambda (monad-input)
     (define result
       (if (memq 'async (monadstate-qtags monad-input))
           (dynamic-thread-async
            (call-with-values
                (lambda _ (monadstate-arg monad-input))
              list))
           (monadstate-lval monad-input)))
     (monadstate-ret/thunk monad-input result))))
