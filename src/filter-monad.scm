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

%var filter-monad

%use (monad-replace) "./monad-replace.scm"
%use (raisu) "./raisu.scm"

;; Skips evaluation based on given predicate
;; NOTE: don't use on multiple-values!
(define (filter-monad test-any)
  (monad-replace
   (lambda (tags arg#lazy)
     (if (or-map test-any tags)
         (lambda _ (raisu 'filter-monad-skipped-evaluation))
         arg#lazy))))
