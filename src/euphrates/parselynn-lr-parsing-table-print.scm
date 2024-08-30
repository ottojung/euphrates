;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define parselynn:lr-parsing-table:print
  (case-lambda
   ((table)
    (parselynn:lr-parsing-table:print table (current-output-port)))

   ((table port)

    (define states
      (parselynn:lr-parsing-table:state:keys table))

    (define actions
      (parselynn:lr-parsing-table:action:keys table))

    (define goto
      (parselynn:lr-parsing-table:goto:keys table))

    (define (action->string elem)
      (cond
       ((parselynn:lr-shift-action? elem)
        (stringf
         "s~s"
         (parselynn:lr-shift-action:target-id elem)))

       ((parselynn:lr-reduce-action? elem)
        (stringf
         "~s← ~a"
         (car (parselynn:lr-reduce-action:production elem))
         (words->string
          (map ~s (cadr (parselynn:lr-reduce-action:production elem))))))

       ((parselynn:lr-accept-action? elem)
        "ACC")

       (else
        (raisu-fmt 'TODO "TODO SUPPORT NONSHIFT"))))

    (define (action-list->string state lst)
      (define strs
        (map action->string lst))

      (define int
        (list-intersperse "/" strs))

      (apply string-append int))

    (define (action-column->string state key)
      (define x
        (parselynn:lr-parsing-table:action:ref
         table state key #f))

      (if x (action-list->string state x) ""))

    (define (goto-item->string state x)
      (cond
       ((parselynn:lr-goto-action? x)
        (parselynn:lr-goto-action:target-id x))
       (else
        (raisu-fmt 'TODO "TODO SUPPORT NONGOTO"))))

    (define (goto-column->string state key)
      (define x
        (parselynn:lr-parsing-table:goto:ref
         table state key #f))

      (if x (goto-item->string state x) ""))

    (define (state->row state)
      (append
       (list state)
       (map (comp (action-column->string state)) actions)
       (map (comp (goto-column->string state)) goto)))

    (define lst-header
      (append
       (list "")
       actions
       goto))

    (define lst-body
      (map state->row states))

    (define lst
      (cons lst-header lst-body))

    (list:display-as-general-table lst)

    (values))))
