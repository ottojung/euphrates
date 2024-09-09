;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; Constructs a parse tree given a parsing table and input tokens interator.
;; Throws exceptions if parsing table contains conflicts.
;;
(define (parselynn:lr-interpret
         parsing-table callback-alist)

  (define initial-state
    (parselynn:lr-parsing-table:state:initial parsing-table))

  (define reject
    (parselynn:lr-reject-action:make))

  (define compiled-table
    (make-hashmap))

  (define (compile-reduction production)
    (define existing (hashmap-ref compiled-table production #f))
    (or existing
        (let ()
          (define callback
            (assoc-or
             production callback-alist
             (cons 'list (bnf-alist:production:get-argument-bindings production))))
          (define new (parselynn:compile-callback production callback))
          (hashmap-set! compiled-table production new)
          new)))

  (define (abort action state category source value)
    (cond
     ((parselynn:lr-reject-action? action)
      'done)

     ((parselynn:lr-parse-conflict? action)
      (raisu* :from "parselynn:lr-interpret"
              :type 'parse-conflict
              :message (stringf "Parsing conflict: ~s." action)
              :args (list action state category source value)))

     (else
      (raisu* :from "parselynn:lr-interpret"
              :type 'unknown-action-type
              :message "Unknown action type."
              :args (list action state category source value)))))

  (lambda (input-tokens-iterator error-procedure)

    (define parse-stack
      (stack-make))

    (define state-stack
      (stack-make))

    (define (do-reject token)
      (if (equal? token parselynn:end-of-input)
          (error-procedure
           'end-of-input "Syntax error: unexpected end of input: ~s" token)
          (error-procedure
           'unexpected-token "Syntax error: unexpected token: ~s" token))
      reject)

    (define (process-accept)
      (stack-peek parse-stack))

    (define (loop-with-input state token category source value)
      (define (process-shift action)
        (stack-push! state-stack state)
        (stack-push! parse-stack value)
        (loop (parselynn:lr-shift-action:target-id action)))

      (define (process-goto lhs)
        (define togo-state (stack-peek state-stack))

        ;; Get the next state after this reduction.
        (define goto-state
          (parselynn:lr-parsing-table:goto:ref
           parsing-table togo-state lhs
           (raisu 'impossible:no-goto-for-reduce-action togo-state lhs)))

        ;; Calculate new state.
        (define new-state
          (parselynn:lr-goto-action:target-id goto-state))

        (loop-with-input new-state token category source value))

      (define (process-reduce action)
        (define production (parselynn:lr-reduce-action:production action))
        (define lhs (bnf-alist:production:lhs production))
        (define rhs (bnf-alist:production:rhs production))

        (define compiled
          (compile-reduction production))

        ;; Construct a new AST node.
        (define new-node
          (apply compiled
                 (cons lhs (stack-pop-multiple! parse-stack (length rhs)))))

        ;; Push the LHS and new node onto the stack.
        (stack-push! parse-stack new-node)

        (stack-push! state-stack state)
        (for-each (lambda _ (stack-pop! state-stack)) rhs)
        (process-goto lhs))

      (define action
        (parselynn:lr-parsing-table:action:ref
         parsing-table state category reject))

      (cond
       ((parselynn:lr-shift-action? action)
        (process-shift action))

       ((parselynn:lr-reduce-action? action)
        (process-reduce action))

       ((parselynn:lr-accept-action? action)
        (process-accept))

       (else
        (abort action state category source value)
        (do-reject token))))

    (define (get-input)
      (define token
        (iterator:next input-tokens-iterator parselynn:end-of-input))

      (if (equal? token parselynn:end-of-input)
          (values token token token token)
          (let ()
            (define category
              (parselynn:token:category token))

            (define source
              (parselynn:token:source token))

            (define value
              (parselynn:token:value token))

            (values token category source value))))

    ;; Main parsing loop.
    (define (loop state)
      (define-values (token category source value) (get-input))
      (loop-with-input state token category source value))

    (loop initial-state)))
