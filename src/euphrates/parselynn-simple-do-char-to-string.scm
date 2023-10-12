;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn/simple-do-char->string
         hidden-tree-labels tree)

  (let loop ((tree tree))
    (cond
     ((list? tree)
      (if (and (pair? tree)
               (hashset-has?
                hidden-tree-labels
                (car tree)))
          (apply string (cdr tree))
          (map loop tree)))
     ((char? tree) (string tree))
     (else tree))))
