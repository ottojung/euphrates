;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:core:signal-lr-conflict type new current on-symbol in-state)
  (define-values (type/print action1 action2)
    (cond
     ((equal? type 'reduce/reduce) (values "Reduce/Reduce" 'reduce 'reduce))
     ((equal? type 'shift/reduce) (values "Shift/Reduce" 'shift 'reduce))
     (else (raisu-fmt 'logic-error "Expected only ~s and ~s, but got ~s"
                      (~a 'reduce/reduce) (~a 'shift/reduce) (~a type/print)))))

  (define message
    (stringf "%% ~a conflict (~a ~a, ~a ~a) on '~a in state ~s"
             type/print action1 new action2 current on-symbol in-state))

  (apply parselynn:core:signal-conflict
         (list message type new current on-symbol in-state)))
