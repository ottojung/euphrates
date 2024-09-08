;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; Constructs a parse tree given a parsing table and input tokens interator.
;; Throws exceptions if parsing table contains conflicts.
;;
(define (parselynn:lr-interpret
         parsing-table callback-alist)

  (lambda (input-tokens-iterator error-procedure)

    (define parse-stack
      (stack-make))

    (define state-stack
      (stack-make))

    (define initial-state
      (parselynn:lr-parsing-table:state:initial parsing-table))

    (define reject
      (parselynn:lr-reject-action:make))

    (define (do-reject token)
      (if (equal? token parselynn:end-of-input)
          (error-procedure
           'end-of-input "Syntax error: unexpected end of input: ~s" token)
          (error-procedure
           'unexpected-token "Syntax error: unexpected token: ~s" token))
      reject)

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

    (define (process-reduce state token category source value action)
      (define production (parselynn:lr-reduce-action:production action))
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
        (do-reject token))

       (else
        (let ()
          ;; Calculate new state.
          (define new-state
            (parselynn:lr-goto-action:target-id goto-state))

          (define compiled
            (compile-reduction production))

          ;; Construct a new AST node.
          (define new-node
            (apply compiled
                   (cons lhs (stack-pop-multiple! parse-stack (length rhs)))))

          ;; Push the LHS and new node onto the stack.
          (stack-push! parse-stack new-node)
          (loop-with-input new-state token category source value)))))

    (define (loop-with-input state token category source value)
      (define action
        (parselynn:lr-parsing-table:action:ref
         parsing-table state category reject))

      (cond
       ((parselynn:lr-shift-action? action)
        (stack-push! state-stack state)
        (stack-push! parse-stack value)
        (loop (parselynn:lr-shift-action:target-id action)))

       ((parselynn:lr-reduce-action? action)
        (process-reduce state token category source value action))

       ((parselynn:lr-accept-action? action)
        (stack-peek parse-stack))

       ((parselynn:lr-reject-action? action)
        (do-reject token))

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
