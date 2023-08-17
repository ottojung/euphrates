;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Treats input list as a tree, and then maps its every leaf.
(define (list-map/deep fun lst)
  (unless (list? lst)
    (raisu* :from 'list-map/deep
            :type 'not-a-list
            :message "Expected a list, but got something else"
            :args (list lst)))

  (let loop ((current lst))
    (cond
     ((list? current) (map loop current))
     (else (fun current)))))
