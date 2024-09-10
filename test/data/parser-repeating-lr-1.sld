(define-library
  (data parser-repeating-lr-1)
  (export parser-repeating-lr-1)
  (import (scheme base) (euphrates stack))
  (begin
    (define parser-repeating-lr-1
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
          ,'((expr (term add expr) : #t (term) : #t)
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
                  (define (do-reject token)
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
                  (define (process-accept)
                    (stack-peek parse-stack))
                  (define (loop-with-input
                           state
                           token
                           category
                           source
                           value)
                    (define (process-shift action)
                      (stack-push! state-stack state)
                      (stack-push! parse-stack value)
                      (loop (parselynn:lr-shift-action:target-id action)))
                    (begin
                      (define (process-goto-add)
                        (define togo-state (stack-peek state-stack))
                        (case togo-state
                          ((0) (do-reject token))
                          ((1) (do-reject token))
                          ((2)
                           (loop-with-input 4 token category source value))
                          ((3) (do-reject token))
                          ((4) (do-reject token))
                          ((5) (do-reject token))
                          ((6) (do-reject token))
                          (else (do-reject token))))
                      (define (process-goto-expr)
                        (define togo-state (stack-peek state-stack))
                        (case togo-state
                          ((0)
                           (loop-with-input 6 token category source value))
                          ((1) (do-reject token))
                          ((2) (do-reject token))
                          ((3) (do-reject token))
                          ((4)
                           (loop-with-input 5 token category source value))
                          ((5) (do-reject token))
                          ((6) (do-reject token))
                          (else (do-reject token))))
                      (define (process-goto-term)
                        (define togo-state (stack-peek state-stack))
                        (case togo-state
                          ((0)
                           (loop-with-input 2 token category source value))
                          ((1) (do-reject token))
                          ((2) (do-reject token))
                          ((3) (do-reject token))
                          ((4)
                           (loop-with-input 2 token category source value))
                          ((5) (do-reject token))
                          ((6) (do-reject token))
                          (else (do-reject token))))
                      (case state
                        ((0)
                         (case category
                           ((NUM) (process-shift 1))
                           (else (do-reject token))))
                        ((1)
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
                            (process-goto-term))
                           (else (do-reject token))))
                        ((2)
                         (case category
                           ((+) (process-shift 3))
                           ((*eoi*)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'expr)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-expr))
                           (else (do-reject token))))
                        ((3)
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
                           (else (do-reject token))))
                        ((4)
                         (case category
                           ((NUM) (process-shift 1))
                           (else (do-reject token))))
                        ((5)
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
                            (process-goto-expr))
                           (else (do-reject token))))
                        ((6)
                         (case category
                           ((*eoi*) (process-accept))
                           (else (do-reject token))))
                        (else (do-reject token)))))
                  (define (get-input)
                    (define token
                      (iterator:next
                        input-tokens-iterator
                        parselynn:end-of-input))
                    (if (equal? token parselynn:end-of-input)
                      (values token token token token)
                      (let ()
                        (define category
                          (parselynn:token:category token))
                        (define source (parselynn:token:source token))
                        (define value (parselynn:token:value token))
                        (values token category source value))))
                  (define (loop state)
                    (define-values
                      (token category source value)
                      (get-input))
                    (loop-with-input
                      state
                      token
                      category
                      source
                      value))
                  (loop initial-state)))))
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
                  (define (do-reject token)
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
                  (define (process-accept)
                    (stack-peek parse-stack))
                  (define (loop-with-input
                           state
                           token
                           category
                           source
                           value)
                    (define (process-shift action)
                      (stack-push! state-stack state)
                      (stack-push! parse-stack value)
                      (loop (parselynn:lr-shift-action:target-id action)))
                    (begin
                      (define (process-goto-add)
                        (define togo-state (stack-peek state-stack))
                        (case togo-state
                          ((0) (do-reject token))
                          ((1) (do-reject token))
                          ((2)
                           (loop-with-input 4 token category source value))
                          ((3) (do-reject token))
                          ((4) (do-reject token))
                          ((5) (do-reject token))
                          ((6) (do-reject token))
                          (else (do-reject token))))
                      (define (process-goto-expr)
                        (define togo-state (stack-peek state-stack))
                        (case togo-state
                          ((0)
                           (loop-with-input 6 token category source value))
                          ((1) (do-reject token))
                          ((2) (do-reject token))
                          ((3) (do-reject token))
                          ((4)
                           (loop-with-input 5 token category source value))
                          ((5) (do-reject token))
                          ((6) (do-reject token))
                          (else (do-reject token))))
                      (define (process-goto-term)
                        (define togo-state (stack-peek state-stack))
                        (case togo-state
                          ((0)
                           (loop-with-input 2 token category source value))
                          ((1) (do-reject token))
                          ((2) (do-reject token))
                          ((3) (do-reject token))
                          ((4)
                           (loop-with-input 2 token category source value))
                          ((5) (do-reject token))
                          ((6) (do-reject token))
                          (else (do-reject token))))
                      (case state
                        ((0)
                         (case category
                           ((NUM) (process-shift 1))
                           (else (do-reject token))))
                        ((1)
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
                            (process-goto-term))
                           (else (do-reject token))))
                        ((2)
                         (case category
                           ((+) (process-shift 3))
                           ((*eoi*)
                            (stack-push!
                              parse-stack
                              (let ()
                                (define $0 'expr)
                                (define $1 (stack-pop! parse-stack))
                                #t))
                            (stack-push! state-stack state)
                            (stack-pop-multiple! state-stack 1)
                            (process-goto-expr))
                           (else (do-reject token))))
                        ((3)
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
                           (else (do-reject token))))
                        ((4)
                         (case category
                           ((NUM) (process-shift 1))
                           (else (do-reject token))))
                        ((5)
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
                            (process-goto-expr))
                           (else (do-reject token))))
                        ((6)
                         (case category
                           ((*eoi*) (process-accept))
                           (else (do-reject token))))
                        (else (do-reject token)))))
                  (define (get-input)
                    (define token
                      (iterator:next
                        input-tokens-iterator
                        parselynn:end-of-input))
                    (if (equal? token parselynn:end-of-input)
                      (values token token token token)
                      (let ()
                        (define category
                          (parselynn:token:category token))
                        (define source (parselynn:token:source token))
                        (define value (parselynn:token:value token))
                        (values token category source value))))
                  (define (loop state)
                    (define-values
                      (token category source value)
                      (get-input))
                    (loop-with-input
                      state
                      token
                      category
                      source
                      value))
                  (loop initial-state))))
            #()))))))

