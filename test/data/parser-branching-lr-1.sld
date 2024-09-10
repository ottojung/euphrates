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
                (define (stack-make) (make-vector 128))
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
                  (define parse-stack-capacity
                    (vector-length parse-stack))
                  (define parse-stack-size 0)
                  (define (push-parse! x)
                    (if (< parse-stack-size parse-stack-capacity)
                      (begin
                        (vector-set! parse-stack parse-stack-size x)
                        (set! parse-stack-size (+ 1 parse-stack-size)))
                      (begin
                        (set! parse-stack-capacity
                          (* 2 parse-stack-capacity))
                        (let ((parse-stack-new
                                (make-vector parse-stack-capacity)))
                          (vector-copy!
                            parse-stack-new
                            0
                            parse-stack
                            0
                            parse-stack-size)
                          (set! parse-stack parse-stack-new))
                        (vector-set! parse-stack parse-stack-size x)
                        (set! parse-stack-size (+ 1 parse-stack-size)))))
                  (define state-stack-capacity
                    (vector-length state-stack))
                  (define state-stack-size 0)
                  (define (push-state! x)
                    (if (< state-stack-size state-stack-capacity)
                      (begin
                        (vector-set! state-stack state-stack-size x)
                        (set! state-stack-size (+ 1 state-stack-size)))
                      (begin
                        (set! state-stack-capacity
                          (* 2 state-stack-capacity))
                        (let ((state-stack-new
                                (make-vector state-stack-capacity)))
                          (vector-copy!
                            state-stack-new
                            0
                            state-stack
                            0
                            state-stack-size)
                          (set! state-stack state-stack-new))
                        (vector-set! state-stack state-stack-size x)
                        (set! state-stack-size (+ 1 state-stack-size)))))
                  (define (state-stack-peek)
                    (vector-ref state-stack (- state-stack-size 1)))
                  (define (parse-stack-peek)
                    (vector-ref parse-stack (- parse-stack-size 1)))
                  (define (parse-pop!)
                    (set! parse-stack-size (- parse-stack-size 1))
                    (vector-ref parse-stack parse-stack-size))
                  (define (state-discard-multiple! n)
                    (set! state-stack-size (- state-stack-size n)))
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
                        (push-state! state)
                        (push-parse! value)
                        (loop (parselynn:lr-shift-action:target-id action)))
                      (define (process-goto-add)
                        (define togo-state (state-stack-peek))
                        (case togo-state
                          ((3) (inner-loop-with-input 5))
                          ((10) (inner-loop-with-input 11))))
                      (define (process-goto-expr)
                        (define togo-state (state-stack-peek))
                        (case togo-state
                          ((0) (inner-loop-with-input 16))
                          ((1) (inner-loop-with-input 9))
                          ((5) (inner-loop-with-input 6))
                          ((7) (inner-loop-with-input 14))
                          ((11) (inner-loop-with-input 12))))
                      (define (process-goto-term)
                        (define togo-state (state-stack-peek))
                        (case togo-state
                          ((0) (inner-loop-with-input 3))
                          ((1) (inner-loop-with-input 10))
                          ((5) (inner-loop-with-input 3))
                          ((7) (inner-loop-with-input 10))
                          ((11) (inner-loop-with-input 10))))
                      (define (parse-stack-0)
                        (define $1 (parse-pop!))
                        (define $0 'term)
                        (push-parse! #t))
                      (define (parse-stack-1)
                        (define $1 (parse-pop!))
                        (define $0 'expr)
                        (push-parse! #t))
                      (define (parse-stack-2)
                        (define $1 (parse-pop!))
                        (define $0 'add)
                        (push-parse! #t))
                      (define (parse-stack-3)
                        (define $3 (parse-pop!))
                        (define $2 (parse-pop!))
                        (define $1 (parse-pop!))
                        (define $0 'expr)
                        (push-parse! #t))
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
                           ((+) (parse-stack-0) (process-goto-term))
                           ((*eoi*) (parse-stack-0) (process-goto-term))))
                        ((3)
                         (case category
                           ((+) (process-shift 4))
                           ((*eoi*) (parse-stack-1) (process-goto-expr))))
                        ((4)
                         (case category
                           ((NUM) (parse-stack-2) (process-goto-add))
                           ((LPAREN) (parse-stack-2) (process-goto-add))))
                        ((5)
                         (case category
                           ((NUM) (process-shift 2))
                           ((LPAREN) (process-shift 1))))
                        ((6)
                         (case category
                           ((*eoi*)
                            (parse-stack-3)
                            (state-discard-multiple! 2)
                            (process-goto-expr))))
                        ((7)
                         (case category
                           ((NUM) (process-shift 8))
                           ((LPAREN) (process-shift 7))))
                        ((8)
                         (case category
                           ((RPAREN) (parse-stack-0) (process-goto-term))
                           ((+) (parse-stack-0) (process-goto-term))))
                        ((9)
                         (case category ((RPAREN) (process-shift 13))))
                        ((10)
                         (case category
                           ((+) (process-shift 4))
                           ((RPAREN) (parse-stack-1) (process-goto-expr))))
                        ((11)
                         (case category
                           ((NUM) (process-shift 8))
                           ((LPAREN) (process-shift 7))))
                        ((12)
                         (case category
                           ((RPAREN)
                            (parse-stack-3)
                            (state-discard-multiple! 2)
                            (process-goto-expr))))
                        ((13)
                         (case category
                           ((*eoi*)
                            (parse-stack-3)
                            (state-discard-multiple! 2)
                            (process-goto-expr))))
                        ((14)
                         (case category ((RPAREN) (process-shift 15))))
                        ((15)
                         (case category
                           ((RPAREN)
                            (parse-stack-3)
                            (state-discard-multiple! 2)
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
                    (parse-stack-peek)
                    (do-reject))))))
        (i3bpqtlnzqjz8ileyrpt
          ,((let ()
              (lambda (actions)
                (define (stack-make) (make-vector 128))
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
                  (define parse-stack-capacity
                    (vector-length parse-stack))
                  (define parse-stack-size 0)
                  (define (push-parse! x)
                    (if (< parse-stack-size parse-stack-capacity)
                      (begin
                        (vector-set! parse-stack parse-stack-size x)
                        (set! parse-stack-size (+ 1 parse-stack-size)))
                      (begin
                        (set! parse-stack-capacity
                          (* 2 parse-stack-capacity))
                        (let ((parse-stack-new
                                (make-vector parse-stack-capacity)))
                          (vector-copy!
                            parse-stack-new
                            0
                            parse-stack
                            0
                            parse-stack-size)
                          (set! parse-stack parse-stack-new))
                        (vector-set! parse-stack parse-stack-size x)
                        (set! parse-stack-size (+ 1 parse-stack-size)))))
                  (define state-stack-capacity
                    (vector-length state-stack))
                  (define state-stack-size 0)
                  (define (push-state! x)
                    (if (< state-stack-size state-stack-capacity)
                      (begin
                        (vector-set! state-stack state-stack-size x)
                        (set! state-stack-size (+ 1 state-stack-size)))
                      (begin
                        (set! state-stack-capacity
                          (* 2 state-stack-capacity))
                        (let ((state-stack-new
                                (make-vector state-stack-capacity)))
                          (vector-copy!
                            state-stack-new
                            0
                            state-stack
                            0
                            state-stack-size)
                          (set! state-stack state-stack-new))
                        (vector-set! state-stack state-stack-size x)
                        (set! state-stack-size (+ 1 state-stack-size)))))
                  (define (state-stack-peek)
                    (vector-ref state-stack (- state-stack-size 1)))
                  (define (parse-stack-peek)
                    (vector-ref parse-stack (- parse-stack-size 1)))
                  (define (parse-pop!)
                    (set! parse-stack-size (- parse-stack-size 1))
                    (vector-ref parse-stack parse-stack-size))
                  (define (state-discard-multiple! n)
                    (set! state-stack-size (- state-stack-size n)))
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
                        (push-state! state)
                        (push-parse! value)
                        (loop (parselynn:lr-shift-action:target-id action)))
                      (define (process-goto-add)
                        (define togo-state (state-stack-peek))
                        (case togo-state
                          ((3) (inner-loop-with-input 5))
                          ((10) (inner-loop-with-input 11))))
                      (define (process-goto-expr)
                        (define togo-state (state-stack-peek))
                        (case togo-state
                          ((0) (inner-loop-with-input 16))
                          ((1) (inner-loop-with-input 9))
                          ((5) (inner-loop-with-input 6))
                          ((7) (inner-loop-with-input 14))
                          ((11) (inner-loop-with-input 12))))
                      (define (process-goto-term)
                        (define togo-state (state-stack-peek))
                        (case togo-state
                          ((0) (inner-loop-with-input 3))
                          ((1) (inner-loop-with-input 10))
                          ((5) (inner-loop-with-input 3))
                          ((7) (inner-loop-with-input 10))
                          ((11) (inner-loop-with-input 10))))
                      (define (parse-stack-0)
                        (define $1 (parse-pop!))
                        (define $0 'term)
                        (push-parse! #t))
                      (define (parse-stack-1)
                        (define $1 (parse-pop!))
                        (define $0 'expr)
                        (push-parse! #t))
                      (define (parse-stack-2)
                        (define $1 (parse-pop!))
                        (define $0 'add)
                        (push-parse! #t))
                      (define (parse-stack-3)
                        (define $3 (parse-pop!))
                        (define $2 (parse-pop!))
                        (define $1 (parse-pop!))
                        (define $0 'expr)
                        (push-parse! #t))
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
                           ((+) (parse-stack-0) (process-goto-term))
                           ((*eoi*) (parse-stack-0) (process-goto-term))))
                        ((3)
                         (case category
                           ((+) (process-shift 4))
                           ((*eoi*) (parse-stack-1) (process-goto-expr))))
                        ((4)
                         (case category
                           ((NUM) (parse-stack-2) (process-goto-add))
                           ((LPAREN) (parse-stack-2) (process-goto-add))))
                        ((5)
                         (case category
                           ((NUM) (process-shift 2))
                           ((LPAREN) (process-shift 1))))
                        ((6)
                         (case category
                           ((*eoi*)
                            (parse-stack-3)
                            (state-discard-multiple! 2)
                            (process-goto-expr))))
                        ((7)
                         (case category
                           ((NUM) (process-shift 8))
                           ((LPAREN) (process-shift 7))))
                        ((8)
                         (case category
                           ((RPAREN) (parse-stack-0) (process-goto-term))
                           ((+) (parse-stack-0) (process-goto-term))))
                        ((9)
                         (case category ((RPAREN) (process-shift 13))))
                        ((10)
                         (case category
                           ((+) (process-shift 4))
                           ((RPAREN) (parse-stack-1) (process-goto-expr))))
                        ((11)
                         (case category
                           ((NUM) (process-shift 8))
                           ((LPAREN) (process-shift 7))))
                        ((12)
                         (case category
                           ((RPAREN)
                            (parse-stack-3)
                            (state-discard-multiple! 2)
                            (process-goto-expr))))
                        ((13)
                         (case category
                           ((*eoi*)
                            (parse-stack-3)
                            (state-discard-multiple! 2)
                            (process-goto-expr))))
                        ((14)
                         (case category ((RPAREN) (process-shift 15))))
                        ((15)
                         (case category
                           ((RPAREN)
                            (parse-stack-3)
                            (state-discard-multiple! 2)
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
                    (parse-stack-peek)
                    (do-reject)))))
            #()))))))

