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

  (define eoi
    parselynn:end-of-input)

  (define (stack-pop-multiple! stack n)
    (let loop ((n n))
      (if (<= n 0) '()
          (let ()
            (define top (stack-pop! stack))
            (cons top (loop (- n 1)))))))

  ;; Push the initial state on the state stack
  (stack-push! state-stack initial-state)

  ;; Main parsing loop
  (define result
    (let loop ((state initial-state))
      (define input
        (iterator:next input-tokens-iterator eoi))

      (define lookup
        (parselynn:lr-parsing-table:action:ref
         parsing-table state input reject))

      (cond
       ((parselynn:lr-reject-action? lookup)
        reject)

       ((parselynn:lr-shift-action? (car lookup))
        (let ((action (car lookup))
              (rest-actions (cdr lookup)))
          (stack-push! state-stack (parselynn:lr-shift-action:target-id action))
          (stack-push! ret input)
          (loop (parselynn:lr-shift-action:target-id action))))

       ((parselynn:lr-reduce-action? (car lookup))
        (let ((action (car lookup))
              (rest-actions (cdr lookup)))
          (define production (parselynn:lr-reduce-action:production action))
          (define lhs (bnf-alist:production:lhs production))
          (define rhs (bnf-alist:production:rhs production))

          ;; Pop the RHS items from the stack
          (for-each (lambda (_) (stack-pop! state-stack)) rhs)

          ;; Construct a new AST node
          (define new-node
            (list
             lhs
             (stack-pop-multiple! ret (length rhs))))

          ;; Push the LHS and new node onto the stack
          (stack-push! ret new-node)

          ;; Get the next state after this reduction
          (define goto-state
            (parselynn:lr-parsing-table:goto:ref
             parsing-table (stack-peek state-stack) lhs reject))

          (if (parselynn:lr-reject-action? goto-state)
              reject
              (begin
                (stack-push! state-stack goto-state)
                (loop goto-state)))))

       ((parselynn:lr-accept-action? (car lookup))
        (stack-peek ret))

       (else
        reject))))

  (if (parselynn:lr-reject-action? result)
      reject
      (reverse
       (stack->list ret))))
