;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:lr-parsing-table:compile table callback-alist)
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
          (hashmap-set! compiled-table production callback)
          callback)))

  (define (generate-goto-function-name lhs)
    (string->symbol
     (string-append
      "process-goto-"
      (symbol->string lhs))))

  (define conflict-handler
    (or (parselynn:core:conflict-handler/p)
        parselynn:core:conflict-handler/default))

  (define (handle-conflict state key x)
    (define actions
      (parselynn:lr-parse-conflict:actions x))
    (define first2 (list-take-n 2 actions))
    (define on-symbol key)
    (define in-state state)
    (define-tuple (action1 action2) first2)

    (define (get-type action)
      (cond
       ((parselynn:lr-shift-action? action)
        "shift")
       ((parselynn:lr-reduce-action? action)
        "reduce")
       (else
        (raisu-fmt 'impossible-6123513 "Expected either shift or reduce here, but got ~s." action))))

    (define type1
      (get-type action1))
    (define type2
      (get-type action2))
    (define type/print
      (string->symbol
       (string-append type1 "/" type2)))
    (define new
      (with-output-stringified
       (parselynn:lr-action:print action1)))
    (define current
      (with-output-stringified
       (parselynn:lr-action:print action2)))

    (define message
      (stringf "%% ~a conflict (~a ~a, ~a ~a) on '~a in state ~s"
               type/print action1 new action2 current on-symbol in-state))

    (apply conflict-handler
           (list message type/print new current on-symbol in-state)))

  (define reject
    (parselynn:lr-reject-action:make))

  (define states
    (parselynn:lr-parsing-table:state:keys table))

  (define (compile-action-for-keystate state key)
    (define x
      (parselynn:lr-parsing-table:action:ref
       table state key reject))

    (cond
     ((parselynn:lr-shift-action? x)
      (list
       (let ()
         (define target-id
           (parselynn:lr-shift-action:target-id x))

         `((,key)
           (process-shift ,target-id)))))

     ((parselynn:lr-reduce-action? x)
      (list
       (let ()
         (define production (parselynn:lr-reduce-action:production x))
         (define lhs (bnf-alist:production:lhs production))
         (define rhs (bnf-alist:production:rhs production))
         (define length-of-rhs (length rhs))

         (define compiled
           (compile-reduction production))

         (define arguments-list
           (bnf-alist:production:get-argument-bindings production))

         (define args-code
           (map
            (lambda (arg)
              `(define ,arg (stack-pop! parse-stack)))
            (reverse (cdr arguments-list))))

         (define goto-function-name
           (begin
             (compile-goto-for-lhs lhs)
             (generate-goto-function-name lhs)))

         `((,key)
           ;; TODO: optimize by factoring code below, and then literally check if any factored function duplicates syntantically.
           (stack-push!
            parse-stack
            (let ()
              (define $0 (quote ,lhs))
              ,@args-code
              ,compiled))

           (push-state! state)
           (stack-pop-multiple! state-stack ,length-of-rhs)  ;; TODO: optimize by simply discarding n - 1?
           (,goto-function-name)))))

     ((parselynn:lr-accept-action? x)
      (list
       `((,key)
         (process-accept))))

     ((parselynn:lr-parse-conflict? x)
      (handle-conflict state key x)
      '())

     ((parselynn:lr-reject-action? x)
      (raisu-fmt 'impossible-172387436 "I asked for non-reject actions."))

     (else
      (raisu-fmt 'unknown-action-type "This action is not expected" x))))

  (define (actions->cases state)
    (define actions
      (parselynn:lr-parsing-table:action:list table state))

    (define single-case-code
      (apply
       append
       (map (comp (compile-action-for-keystate state)) actions)))

    (if (null? single-case-code)
        '()
        (list
         `((,state)
           (case category
             ,@single-case-code)))))

  (define (compile-goto-for-keystate key state)
    (define x
      (parselynn:lr-parsing-table:goto:ref
       table state key reject))

    (cond
     ((parselynn:lr-goto-action? x)
      (let ()
        (define new-state (parselynn:lr-goto-action:target-id x))
        (list
         `((,state)
           (inner-loop-with-input ,new-state)))))

     ((parselynn:lr-parse-conflict? x)
      (handle-conflict state key x))

     ((parselynn:lr-reject-action? x)
      '()) ;; Handled by upper reject.

     (else
      (raisu-fmt 'unknown-action-type "This action is not expected" x))))

  (define goto-procedures-code-hashmap
    (make-hashmap))

  (define (compile-goto-for-lhs lhs)
    (or (hashmap-ref goto-procedures-code-hashmap lhs #f)
        (let ()
          (define name (generate-goto-function-name lhs))
          (define new-cases
            (apply
             append
             (map (comp (compile-goto-for-keystate lhs)) states)))
          (define new
            ;; TODO: optimize by literally checking if any function duplicates syntantically.
            `(define (,name)
               (define togo-state (stack-peek state-stack))
               (case togo-state ,@new-cases)))
          (hashmap-set! goto-procedures-code-hashmap lhs new)
          new)))

  (define action-case-code
    (apply
     append
     (map actions->cases states)))

  (define goto-code
    (filter
     identity
     (map
      compile-goto-for-lhs
      (parselynn:lr-parsing-table:goto:keys table))))

  (define code
    (if (null? action-case-code)
        'reject
        `(let inner-loop-with-input ((state state))
           (define (process-shift action)
             (push-state! state)
             (push-parse! value)
             (loop (parselynn:lr-shift-action:target-id action)))

           ,@goto-code

           (case state
             ,@action-case-code))))

  code)
