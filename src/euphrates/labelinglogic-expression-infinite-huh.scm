;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:infinite? expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))

  (define simple
    (labelinglogic:expression:desugar
     (labelinglogic:expression:move-nots-down expr)))

  (define constants
    0)

  (when (equal? type 'constant)
    (raisu* :from "labelinglogic:expression:infinite?"
            :type 'bad-sub-expr-type
            :message (stringf "Expression type ~s not permitted here." (~a type))
            :args (list type expr)))

  (or (equal? type 'not)
      0))
