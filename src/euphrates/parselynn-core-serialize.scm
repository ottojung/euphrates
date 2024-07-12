;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:core:serialize parser)
  (define results-mode (parselynn:core:struct:results parser))
  (define driver-name (parselynn:core:struct:driver parser))
  (define tokens (parselynn:core:struct:tokens parser))
  (define rules (parselynn:core:struct:rules parser))
  (define code-actions (parselynn:core:struct:actions parser))
  (define code (parselynn:core:struct:code parser))

  `(let ()
     (define maybefun0 ,code)
     (define code-actions ,code-actions)
     (define maybefun (maybefun0 code-actions))
     (vector (quote ,parselynn:core:serialized-typetag)
             (quote ,results-mode)
             (quote ,driver-name)
             (quote ,tokens)
             (quote ,rules)
             code-actions
             (quote ,code)
             maybefun)))
