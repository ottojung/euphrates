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

;; This is a hashmap that is optimized for read and copy
;; It makes a new copy on each write

%var immutable-hashmap-constructor
%var immutable-hashmap-predicate
%var immutable-hashmap-value

%use (define-type9) "./define-type9.scm"

(define-type9 immutable-hashmap
  (immutable-hashmap-constructor value) immutable-hashmap-predicate
  (value immutable-hashmap-value))
