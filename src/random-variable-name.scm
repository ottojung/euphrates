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

%run guile

%var random-variable-name

%use (random-choice) "./random-choice.scm"
%use (alphanum-lowercase/alphabet) "./alphanum-lowercase-alphabet.scm"
%use (alpha-lowercase/alphabet) "./alpha-lowercase-alphabet.scm"
%use (big-random-int) "./big-random-int.scm"
%use (raisu) "./raisu.scm"

(define (random-variable-name name-length)
  (unless (and (integer? name-length)
               (< 0 name-length))
    (raisu 'name-length-should-be-a-positive-integer name-length))

  (list->string
   (cons (vector-ref alpha-lowercase/alphabet
                     (big-random-int
                      (vector-length alpha-lowercase/alphabet)))
         (random-choice (- name-length 1)
                        alphanum-lowercase/alphabet))))
