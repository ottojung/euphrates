;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; Constructs a parse tree given a parsing table and input tokens interator.
;; Throws exceptions if parsing table contains conflicts.
;;
(define (parselynn:lr-interpret parsing-table input-tokens-iterator)
  (define ret
    (stack-make))

  (define state-stack
    (stack-make))

  (define initial-state
    (parselynn:lr-parsing-table:state:initial parsing-table))

  (define reject
    (parselynn:lr-reject-action:make))

  (define (process-reduce state input action)
    (define production (parselynn:lr-reduce-action:production action))
    (define lhs (bnf-alist:production:lhs production))
    (define rhs (bnf-alist:production:rhs production))

    ;; Pop the RHS items from the stack.
    (define _7336
      (for-each (lambda _ (stack-pop! state-stack)) rhs))

    ;; Construct a new AST node.
    (define new-node
      (cons lhs (stack-pop-multiple! ret (length rhs))))

    (define togo-state
      (stack-peek state-stack))

    ;; Get the next state after this reduction.
    (define goto-state
      (parselynn:lr-parsing-table:goto:ref
       parsing-table togo-state lhs reject))

    ;; Push the LHS and new node onto the stack.
    (stack-push! ret new-node)

    (cond
     ((parselynn:lr-reject-action? goto-state)
      reject)

     (else
      (let ()
        (define new-state
          (parselynn:lr-goto-action:target-id goto-state))
        (loop-with-input new-state input)))))

  (define (process-action state input action)
    (cond
     ((parselynn:lr-accept-action? action)
      (stack-peek ret))

     ((parselynn:lr-shift-action? action)
      (stack-push! ret input)
      (loop (parselynn:lr-shift-action:target-id action)))

     ((parselynn:lr-reduce-action? action)
      (process-reduce state input action))

     (else
      (raisu* :from "parselynn:lr-interpret"
              :type 'unknown-action-type
              :message "Unknown action type"
              :args (list action state input)))))

  (define (action->string action)
    (with-output-stringified
     (parselynn:lr-action:print action)))

  (define (get-input)
    (iterator:next input-tokens-iterator parselynn:end-of-input))

  ;; Main parsing loop.
  (define (loop-with-input state input)
    ;; Push state on the state stack.
    (stack-push! state-stack state)

    (define lookup
      (parselynn:lr-parsing-table:action:ref
       parsing-table state input reject))

    (cond
     ((parselynn:lr-reject-action? lookup)
      reject)

     ((list-singleton? lookup)
      (process-action state input (car lookup)))

     (else
      (raisu* :from "parselynn:lr-interpret"
              :type 'parse-conflict
              :message (stringf "Parsing conflict: ~s" lookup)
              :args (list lookup)))))

  (define (loop state)
    (define input (get-input))
    (loop-with-input state input))

  (define result
    (loop initial-state))

  (define args
    result)

  (if (parselynn:lr-reject-action? result)
      reject
      args))
