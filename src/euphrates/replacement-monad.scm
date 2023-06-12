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




;; Replaces expressions by different ones based on associted tags
;; Can be used for deriving many less general monads, like lazy-monad or filter-monad
(define (replacement-monad test/replace-procedure)
  (monad-make/no-cont
   (lambda (monad-input)
     (let ((tags (monadstate-qtags monad-input))
           (arg#lazy (monadstate-lval monad-input)))
       (monadstate-ret/thunk (test/replace-procedure tags arg#lazy))))))
