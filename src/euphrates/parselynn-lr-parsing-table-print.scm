;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define parselynn:lr-parsing-table:print
  (case-lambda
   ((table)
    (parselynn:lr-parsing-table:print table (current-output-port)))

   ((table port)

    (define reject
      (parselynn:lr-reject-action:make))

    (define states
      (parselynn:lr-parsing-table:state:keys table))

    (define actions
      (parselynn:lr-parsing-table:action:keys table))

    (define goto
      (parselynn:lr-parsing-table:goto:keys table))

    (define (action-column->string state key)
      (define x
        (parselynn:lr-parsing-table:action:ref
         table state key reject))

      (with-output-stringified
       (cond
        ((parselynn:lr-parse-conflict? x)
         (parselynn:lr-parse-conflict:print x))

        (else
         (parselynn:lr-action:print x)))))

    (define (goto-column->string state key)
      (define x
        (parselynn:lr-parsing-table:goto:ref
         table state key #f))

      (with-output-stringified
       (when x
         (parselynn:lr-action:print x))))

    (define (state->row state)
      (append
       (list state)
       (map (comp (action-column->string state)) actions)
       (map (comp (goto-column->string state)) goto)))

    (define lst-header
      (append
       (list "")
       (map
        (lambda (action)
          (if (equal? action parselynn:end-of-input) "$" action))
        actions)
       goto))

    (define lst-body
      (map state->row states))

    (define lst
      (cons lst-header lst-body))

    (list:display-as-general-table lst)

    (values))))
