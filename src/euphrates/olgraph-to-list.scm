;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (olnode->list olnode)
  ;; Traverses the `olnode` collecting all `value`s from it,
  ;; and putting them in a list.
  ;; Assumes that the graph represented by `olnode`
  ;; is not recursive.
  ;; Resulting list is recursive.
  ;; First element of each branch is the value,
  ;; and the rest are the children of that node.

  (let loop ((olnode olnode))
    (let ((value (olnode:value olnode))
          (children (olnode:children olnode)))
      (cons value (map loop children)))))
