(define-library
  (data parser-branching-lr-1)
  (export parser-branching-lr-1)
  (import (scheme base) (euphrates stack))
  (begin
    (define parser-branching-lr-1
      `((cqqn4gukh9w0rx195m2c
          ,'*serialized-lalr-scm-parser*)
        (vasml2yhpvo1iq0ofir7 ,'first)
        (nx8lw4j8m9qkhnks1lnb ,'lr-1-driver)
        (ill9vlxm3pyptw40uotx
          ,'(ID NUM
                =
                +
                -
                *
                /
                LPAREN
                RPAREN
                SPACE
                NEWLINE
                COMMA))
        (qofpa1t73vde5nivj6d9
          ,'((expr (term add expr)
                   :
                   #t
                   (LPAREN expr RPAREN)
                   :
                   #t
                   (term)
                   :
                   #t)
             (add (+) : #t)
             (term (NUM) : #t)))
        (obs163lvp06p9m10bwjy ,#())
        (wgq4fdim7f2kx3zj610r
          ,'(let ()
              (lambda (actions)
                (define (parselynn:lr-shift-action:target-id x)
                  x)
                (define (parselynn:token:category x)
                  (vector-ref x 1))
                (define (parselynn:token:source x)
                  (vector-ref x 2))
                (define (parselynn:token:value x)
                  (vector-ref x 3))
                (define parselynn:end-of-input '*eoi*)
                (define-syntax iterator:next
                  (syntax-rules () ((_ iter default) (iter))))
                (define initial-state 0)
                (define (parselynn:lr-reject-action:make) #f)
                (define (parselynn:lr-reject-action? obj)
                  (equal? reject obj))
                (define reject (parselynn:lr-reject-action:make))
                (lambda (___scanner ___errorp)
                  (define get-next-token
                    (let () (lambda args (___scanner))))
                  (define input-tokens-iterator get-next-token)
                  (define error-procedure ___errorp)
                  (define parse-stack (stack-make))
                  (define state-stack (stack-make))
                  (define (process-accept) 'ACCEPT)
                  (define token #f)
                  (define (do-reject)
                    (if (equal? token parselynn:end-of-input)
                      (error-procedure
                        'end-of-input
                        "Syntax error: unexpected end of input: ~s"
                        token)
                      (error-procedure
                        'unexpected-token
                        "Syntax error: unexpected token: ~s"
                        token))
                    reject)
                  (define (loop-with-input state category source value)
                    (let inner-loop-with-input ((state state))
                      (define (process-shift action)
                        (stack-push! state-stack state)
                        (stack-push! parse-stack value)
                        (loop (parselynn:lr-shift-action:target-id action)))
                      (define (process-goto-add)
                        (define togo-state (stack-peek state-stack))
                        (case togo-state
                          ((3) (inner-loop-with-input 5))
                          ((10) (inner-loop-with-input 11))))
                      (define (process-goto-expr)
                        (define togo-state (stack-peek state-stack))
                        (case togo-state
                          ((0) (inner-loop-with-input 16))
                          ((1) (inner-loop-with-input 9))
                          ((5) (inner-loop-with-input 6))
                          ((7) (inner-loop-with-input 14))
                          ((11) (inner-loop-with-input 12))))
                      (define (process-goto-term)
                        (define togo-state (stack-peek state-stack))
                        (case togo-state
                          ((0) (inner-loop-with-input 3))
                          ((1) (inner-loop-with-input 10))
                          ((5) (inner-loop-with-input 3))
                          ((7) (inner-loop-with-input 10))
                          ((11) (inner-loop-with-input 10))))
                      (case state
                        ((0)
                         (case category
                           ((NUM) (process-shift 2))
                           ((LPAREN) (process-shift 1))))
                        ((1)
                         (case category
                           ((NUM) (process-shift 8))
                           ((LPAREN) (process-shift 7))))
                        ((2)
                         (case category
                           ((+)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'term)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-term))
                           ((*eoi*)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'term)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-term))))
                        ((3)
                         (case category
                           ((+) (process-shift 4))
                           ((*eoi*)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'expr)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-expr))))
                        ((4)
                         (case category
                           ((NUM)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'add)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-add))
                           ((LPAREN)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'add)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-add))))
                        ((5)
                         (case category
                           ((NUM) (process-shift 2))
                           ((LPAREN) (process-shift 1))))
                        ((6)
                         (case category
                           ((*eoi*)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'expr)
                                (define $3 (stack-pop! parse-stack))
                                (define $2 (stack-pop! parse-stack))
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 3)
                            (process-goto-expr))))
                        ((7)
                         (case category
                           ((NUM) (process-shift 8))
                           ((LPAREN) (process-shift 7))))
                        ((8)
                         (case category
                           ((RPAREN)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'term)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-term))
                           ((+)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'term)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-term))))
                        ((9)
                         (case category ((RPAREN) (process-shift 13))))
                        ((10)
                         (case category
                           ((+) (process-shift 4))
                           ((RPAREN)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'expr)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-expr))))
                        ((11)
                         (case category
                           ((NUM) (process-shift 8))
                           ((LPAREN) (process-shift 7))))
                        ((12)
                         (case category
                           ((RPAREN)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'expr)
                                (define $3 (stack-pop! parse-stack))
                                (define $2 (stack-pop! parse-stack))
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 3)
                            (process-goto-expr))))
                        ((13)
                         (case category
                           ((*eoi*)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'expr)
                                (define $3 (stack-pop! parse-stack))
                                (define $2 (stack-pop! parse-stack))
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 3)
                            (process-goto-expr))))
                        ((14)
                         (case category ((RPAREN) (process-shift 15))))
                        ((15)
                         (case category
                           ((RPAREN)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'expr)
                                (define $3 (stack-pop! parse-stack))
                                (define $2 (stack-pop! parse-stack))
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 3)
                            (process-goto-expr))))
                        ((16) (case category ((*eoi*) (process-accept)))))))
                  (define (get-input)
                    (set! token
                      (iterator:next
                        input-tokens-iterator
                        parselynn:end-of-input))
                    (if (equal? token parselynn:end-of-input)
                      (values token token token)
                      (let ()
                        (define category
                          (parselynn:token:category token))
                        (define source (parselynn:token:source token))
                        (define value (parselynn:token:value token))
                        (values category source value))))
                  (define (loop state)
                    (define-values
                      (category source value)
                      (get-input))
                    (loop-with-input state category source value))
                  (if (equal? 'ACCEPT (loop initial-state))
                    (stack-peek parse-stack)
                    (do-reject))))))
        (i3bpqtlnzqjz8ileyrpt
          ,((let ()
              (lambda (actions)
                (define (parselynn:lr-shift-action:target-id x)
                  x)
                (define (parselynn:token:category x)
                  (vector-ref x 1))
                (define (parselynn:token:source x)
                  (vector-ref x 2))
                (define (parselynn:token:value x)
                  (vector-ref x 3))
                (define parselynn:end-of-input '*eoi*)
                (define-syntax iterator:next
                  (syntax-rules () ((_ iter default) (iter))))
                (define initial-state 0)
                (define (parselynn:lr-reject-action:make) #f)
                (define (parselynn:lr-reject-action? obj)
                  (equal? reject obj))
                (define reject (parselynn:lr-reject-action:make))
                (lambda (___scanner ___errorp)
                  (define get-next-token
                    (let () (lambda args (___scanner))))
                  (define input-tokens-iterator get-next-token)
                  (define error-procedure ___errorp)
                  (define parse-stack (stack-make))
                  (define state-stack (stack-make))
                  (define (process-accept) 'ACCEPT)
                  (define token #f)
                  (define (do-reject)
                    (if (equal? token parselynn:end-of-input)
                      (error-procedure
                        'end-of-input
                        "Syntax error: unexpected end of input: ~s"
                        token)
                      (error-procedure
                        'unexpected-token
                        "Syntax error: unexpected token: ~s"
                        token))
                    reject)
                  (define (loop-with-input state category source value)
                    (let inner-loop-with-input ((state state))
                      (define (process-shift action)
                        (stack-push! state-stack state)
                        (stack-push! parse-stack value)
                        (loop (parselynn:lr-shift-action:target-id action)))
                      (define (process-goto-add)
                        (define togo-state (stack-peek state-stack))
                        (case togo-state
                          ((3) (inner-loop-with-input 5))
                          ((10) (inner-loop-with-input 11))))
                      (define (process-goto-expr)
                        (define togo-state (stack-peek state-stack))
                        (case togo-state
                          ((0) (inner-loop-with-input 16))
                          ((1) (inner-loop-with-input 9))
                          ((5) (inner-loop-with-input 6))
                          ((7) (inner-loop-with-input 14))
                          ((11) (inner-loop-with-input 12))))
                      (define (process-goto-term)
                        (define togo-state (stack-peek state-stack))
                        (case togo-state
                          ((0) (inner-loop-with-input 3))
                          ((1) (inner-loop-with-input 10))
                          ((5) (inner-loop-with-input 3))
                          ((7) (inner-loop-with-input 10))
                          ((11) (inner-loop-with-input 10))))
                      (case state
                        ((0)
                         (case category
                           ((NUM) (process-shift 2))
                           ((LPAREN) (process-shift 1))))
                        ((1)
                         (case category
                           ((NUM) (process-shift 8))
                           ((LPAREN) (process-shift 7))))
                        ((2)
                         (case category
                           ((+)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'term)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-term))
                           ((*eoi*)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'term)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-term))))
                        ((3)
                         (case category
                           ((+) (process-shift 4))
                           ((*eoi*)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'expr)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-expr))))
                        ((4)
                         (case category
                           ((NUM)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'add)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-add))
                           ((LPAREN)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'add)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-add))))
                        ((5)
                         (case category
                           ((NUM) (process-shift 2))
                           ((LPAREN) (process-shift 1))))
                        ((6)
                         (case category
                           ((*eoi*)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'expr)
                                (define $3 (stack-pop! parse-stack))
                                (define $2 (stack-pop! parse-stack))
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 3)
                            (process-goto-expr))))
                        ((7)
                         (case category
                           ((NUM) (process-shift 8))
                           ((LPAREN) (process-shift 7))))
                        ((8)
                         (case category
                           ((RPAREN)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'term)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-term))
                           ((+)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'term)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-term))))
                        ((9)
                         (case category ((RPAREN) (process-shift 13))))
                        ((10)
                         (case category
                           ((+) (process-shift 4))
                           ((RPAREN)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'expr)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-expr))))
                        ((11)
                         (case category
                           ((NUM) (process-shift 8))
                           ((LPAREN) (process-shift 7))))
                        ((12)
                         (case category
                           ((RPAREN)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'expr)
                                (define $3 (stack-pop! parse-stack))
                                (define $2 (stack-pop! parse-stack))
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 3)
                            (process-goto-expr))))
                        ((13)
                         (case category
                           ((*eoi*)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'expr)
                                (define $3 (stack-pop! parse-stack))
                                (define $2 (stack-pop! parse-stack))
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 3)
                            (process-goto-expr))))
                        ((14)
                         (case category ((RPAREN) (process-shift 15))))
                        ((15)
                         (case category
                           ((RPAREN)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'expr)
                                (define $3 (stack-pop! parse-stack))
                                (define $2 (stack-pop! parse-stack))
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 3)
                            (process-goto-expr))))
                        ((16) (case category ((*eoi*) (process-accept)))))))
                  (define (get-input)
                    (set! token
                      (iterator:next
                        input-tokens-iterator
                        parselynn:end-of-input))
                    (if (equal? token parselynn:end-of-input)
                      (values token token token)
                      (let ()
                        (define category
                          (parselynn:token:category token))
                        (define source (parselynn:token:source token))
                        (define value (parselynn:token:value token))
                        (values category source value))))
                  (define (loop state)
                    (define-values
                      (category source value)
                      (get-input))
                    (loop-with-input state category source value))
                  (if (equal? 'ACCEPT (loop initial-state))
                    (stack-peek parse-stack)
                    (do-reject)))))
            #()))))))

