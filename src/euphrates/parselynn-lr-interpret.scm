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
    (define callback (parselynn:lr-reduce-action:callback action))
    (define lhs (bnf-alist:production:lhs production))
    (define rhs (bnf-alist:production:rhs production))

    (define togo-state
      (let ()
        (stack-push! state-stack state)
        (for-each (lambda _ (stack-pop! state-stack)) rhs)
        (stack-peek state-stack)))

    ;; Get the next state after this reduction.
    (define goto-state
      (parselynn:lr-parsing-table:goto:ref
       parsing-table togo-state lhs reject))

    (cond
     ((parselynn:lr-reject-action? goto-state)
      reject)

     (else
      (let ()
        ;; Calculate new state.
        (define new-state
          (parselynn:lr-goto-action:target-id goto-state))

        ;; Construct a new AST node.
        (define new-node
          (apply callback
                 (cons lhs (stack-pop-multiple! ret (length rhs)))))

        ;; Push the LHS and new node onto the stack.
        (stack-push! ret new-node)
        (loop-with-input new-state input)))))

  (define (loop-with-input state input)
    (define action
      (parselynn:lr-parsing-table:action:ref
       parsing-table state input reject))

    (cond
     ((parselynn:lr-shift-action? action)
      (stack-push! state-stack state)
      (stack-push! ret input)
      (loop (parselynn:lr-shift-action:target-id action)))

     ((parselynn:lr-reduce-action? action)
      (process-reduce state input action))

     ((parselynn:lr-accept-action? action)
      (stack-peek ret))

     ((parselynn:lr-reject-action? action)
      reject)

     ((parselynn:lr-parse-conflict? action)
      (raisu* :from "parselynn:lr-interpret"
              :type 'parse-conflict
              :message (stringf "Parsing conflict: ~s." action)
              :args (list action state input)))

     (else
      (raisu* :from "parselynn:lr-interpret"
              :type 'unknown-action-type
              :message "Unknown action type."
              :args (list action state input)))))

  (define (get-input)
    (iterator:next input-tokens-iterator parselynn:end-of-input))

  ;; Main parsing loop.
  (define (loop state)
    (define input (get-input))
    (loop-with-input state input))

  (loop initial-state))
