;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:infinite? expr)
  (define simple
    (labelinglogic:expression:desugar
     (labelinglogic:expression:move-nots-down expr)))

  (define type (labelinglogic:expression:type simple))
  (define args (labelinglogic:expression:args simple))

  (when (equal? type 'constant)
    (raisu* :from "labelinglogic:expression:infinite?"
            :type 'bad-expr-type
            :message (stringf "Expression type ~s not permitted here." (~a type))
            :args (list type expr)))

  (define constants
    (labelinglogic:expression:constants simple))

  (unless (null? constants)
    (raisu* :from "labelinglogic:expression:infinite?"
            :type 'contains-bad-types
            :message (stringf "Expression contains type ~s, which is not permitted here." (~a 'constant))
            :args (list 'constant constants expr)))

  (or (equal? type 'not)
      (equal? type 'r7rs)
      (labelinglogic:expression:top? simple)))
