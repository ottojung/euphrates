;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:optimize/assuming-nointersect expr)
  (define dnf
    (labelinglogic:expression:to-dnf expr))

  (define dnf-type
    (labelinglogic:expression:type dnf))

  (define dnf*
    (if (equal? 'or dnf-type)
        (labelinglogic:expression:make
         dnf-type
         (list-deduplicate
          (labelinglogic:expression:args dnf)))
        dnf))

  (define simpl
    
