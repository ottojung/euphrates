;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:dnf-r7rs-clause? x)
  (and (labelinglogic:expression? x)
       (let loop ((expr x))
         (define type (labelinglogic:expression:type expr))
         (define args (labelinglogic:expression:args expr))

         (or (equal? 'r7rs type)
             (and (equal? 'and type)
                  (list-or-map loop args))))))

