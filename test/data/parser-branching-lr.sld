(define-library
  (data parser-branching-lr)
  (export parser-branching-lr)
  (import (scheme base))
  (begin
    (define parser-branching-lr
      (let ()
        (define maybefun0
          (let ()
            (define (cadar l) (car (cdr (car l))))
            (define (drop l n)
              (cond ((and (> n 0) (pair? l)) (drop (cdr l) (- n 1)))
                    (else l)))
            (define (take-right l n)
              (drop l (- (length l) n)))
            (define (note-source-location lvalue tok) lvalue)
            (define (lexical-token? x)
              (and (vector? x)
                   (= 4 (vector-length x))
                   (equal? (vector-ref x 0) '*lexical-token*)))
            (define (lexical-token-category x)
              (vector-ref x 1))
            (define (lexical-token-source x)
              (vector-ref x 2))
            (define (lexical-token-value x) (vector-ref x 3))
            (define action-table
              '#(((*default* *error*) (NUM 2) (LPAREN 1))
                 ((*default* *error*) (NUM 2) (LPAREN 1))
                 ((*default* -6))
                 ((*default* -4))
                 ((*default* *error*) (*eoi* 7) (+ 6))
                 ((*default* *error*) (+ 6) (RPAREN 9))
                 ((*default* -5))
                 ((*default* -1) (*eoi* accept))
                 ((*default* *error*) (NUM 2) (LPAREN 1))
                 ((*default* -3))
                 ((*default* -2) (+ 6))))
            (define goto-table
              (vector
                '((3 . 3) (1 . 4))
                '((3 . 3) (1 . 5))
                '()
                '()
                '((2 . 8))
                '((2 . 8))
                '()
                '()
                '((3 . 3) (1 . 10))
                '()
                '((2 . 8))))
            (lambda (actions)
              (define (external index . args)
                (apply (vector-ref actions index) args))
              (define reduction-table
                (vector
                  '()
                  (lambda (___stack ___sp ___goto-table ___push yypushback)
                    (let* ((tok (vector-ref ___stack (- ___sp 1)))
                           ($2 (if (lexical-token? tok)
                                 (lexical-token-value tok)
                                 tok))
                           (@2 (if (lexical-token? tok)
                                 (lexical-token-source tok)
                                 tok))
                           (tok (vector-ref ___stack (- ___sp 3)))
                           ($1 (if (lexical-token? tok)
                                 (lexical-token-value tok)
                                 tok))
                           (@1 (if (lexical-token? tok)
                                 (lexical-token-source tok)
                                 tok)))
                      $1))
                  (lambda (___stack ___sp ___goto-table ___push yypushback)
                    (let* ((tok (vector-ref ___stack (- ___sp 1)))
                           ($3 (if (lexical-token? tok)
                                 (lexical-token-value tok)
                                 tok))
                           (@3 (if (lexical-token? tok)
                                 (lexical-token-source tok)
                                 tok))
                           (tok (vector-ref ___stack (- ___sp 3)))
                           ($2 (if (lexical-token? tok)
                                 (lexical-token-value tok)
                                 tok))
                           (@2 (if (lexical-token? tok)
                                 (lexical-token-source tok)
                                 tok))
                           (tok (vector-ref ___stack (- ___sp 5)))
                           ($1 (if (lexical-token? tok)
                                 (lexical-token-value tok)
                                 tok))
                           (@1 (if (lexical-token? tok)
                                 (lexical-token-source tok)
                                 tok)))
                      (___push
                        3
                        1
                        #t
                        (vector-ref ___stack (- ___sp 3)))))
                  (lambda (___stack ___sp ___goto-table ___push yypushback)
                    (let* ((tok (vector-ref ___stack (- ___sp 1)))
                           ($3 (if (lexical-token? tok)
                                 (lexical-token-value tok)
                                 tok))
                           (@3 (if (lexical-token? tok)
                                 (lexical-token-source tok)
                                 tok))
                           (tok (vector-ref ___stack (- ___sp 3)))
                           ($2 (if (lexical-token? tok)
                                 (lexical-token-value tok)
                                 tok))
                           (@2 (if (lexical-token? tok)
                                 (lexical-token-source tok)
                                 tok))
                           (tok (vector-ref ___stack (- ___sp 5)))
                           ($1 (if (lexical-token? tok)
                                 (lexical-token-value tok)
                                 tok))
                           (@1 (if (lexical-token? tok)
                                 (lexical-token-source tok)
                                 tok)))
                      (___push
                        3
                        1
                        #t
                        (vector-ref ___stack (- ___sp 3)))))
                  (lambda (___stack ___sp ___goto-table ___push yypushback)
                    (let* ((tok (vector-ref ___stack (- ___sp 1)))
                           ($1 (if (lexical-token? tok)
                                 (lexical-token-value tok)
                                 tok))
                           (@1 (if (lexical-token? tok)
                                 (lexical-token-source tok)
                                 tok)))
                      (___push
                        1
                        1
                        #t
                        (vector-ref ___stack (- ___sp 1)))))
                  (lambda (___stack ___sp ___goto-table ___push yypushback)
                    (let* ((tok (vector-ref ___stack (- ___sp 1)))
                           ($1 (if (lexical-token? tok)
                                 (lexical-token-value tok)
                                 tok))
                           (@1 (if (lexical-token? tok)
                                 (lexical-token-source tok)
                                 tok)))
                      (___push
                        1
                        2
                        #t
                        (vector-ref ___stack (- ___sp 1)))))
                  (lambda (___stack ___sp ___goto-table ___push yypushback)
                    (let* ((tok (vector-ref ___stack (- ___sp 1)))
                           ($1 (if (lexical-token? tok)
                                 (lexical-token-value tok)
                                 tok))
                           (@1 (if (lexical-token? tok)
                                 (lexical-token-source tok)
                                 tok)))
                      (___push
                        1
                        3
                        #t
                        (vector-ref ___stack (- ___sp 1)))))))
              (lambda (___scanner ___errorp)
                (define get-next-token
                  (lambda args (___scanner)))
                (define *initial-stack-size* 500)
                (define ___atable action-table)
                (define ___gtable goto-table)
                (define ___rtable reduction-table)
                (define ___stack #f)
                (define ___sp 0)
                (define ___curr-input #f)
                (define ___reuse-input #f)
                (define ___input #f)
                (define (___consume)
                  (set! ___input
                    (if ___reuse-input
                      ___curr-input
                      (get-next-token)))
                  (set! ___reuse-input #f)
                  (set! ___curr-input ___input))
                (define (___pushback) (set! ___reuse-input #t))
                (define (___initstack)
                  (set! ___stack
                    (make-vector *initial-stack-size* 0))
                  (set! ___sp 0))
                (define (___growstack)
                  (let ((new-stack
                          (make-vector (* 2 (vector-length ___stack)) 0)))
                    (let loop ((i (- (vector-length ___stack) 1)))
                      (if (>= i 0)
                        (begin
                          (vector-set! new-stack i (vector-ref ___stack i))
                          (loop (- i 1)))))
                    (set! ___stack new-stack)))
                (define (___checkstack)
                  (if (>= ___sp (vector-length ___stack))
                    (___growstack)))
                (define (___push delta new-category lvalue tok)
                  (set! ___sp (- ___sp (* delta 2)))
                  (let* ((state (vector-ref ___stack ___sp))
                         (new-state
                           (cdr (assoc new-category
                                       (vector-ref ___gtable state)))))
                    (set! ___sp (+ ___sp 2))
                    (___checkstack)
                    (vector-set! ___stack ___sp new-state)
                    (vector-set!
                      ___stack
                      (- ___sp 1)
                      (note-source-location lvalue tok))))
                (define (___reduce st)
                  ((vector-ref ___rtable st)
                   ___stack
                   ___sp
                   ___gtable
                   ___push
                   ___pushback))
                (define (___shift token attribute)
                  (set! ___sp (+ ___sp 2))
                  (___checkstack)
                  (vector-set! ___stack (- ___sp 1) attribute)
                  (vector-set! ___stack ___sp token))
                (define (___action x l)
                  (let ((y (assoc x l))) (if y (cadr y) (cadar l))))
                (define (___recover tok)
                  (let find-state ((sp ___sp))
                    (if (< sp 0)
                      (set! ___sp sp)
                      (let* ((state (vector-ref ___stack sp))
                             (act (assoc 'error (vector-ref ___atable state))))
                        (if act
                          (begin (set! ___sp sp) (___sync (cadr act) tok))
                          (find-state (- sp 2)))))))
                (define (___sync state tok)
                  (let ((sync-set
                          (map car (cdr (vector-ref ___atable state)))))
                    (set! ___sp (+ ___sp 4))
                    (___checkstack)
                    (vector-set! ___stack (- ___sp 3) #f)
                    (vector-set! ___stack (- ___sp 2) state)
                    (let skip ()
                      (let ((i (___category ___input)))
                        (if (equal? i '*eoi*)
                          (set! ___sp -1)
                          (if (memq i sync-set)
                            (let ((act (assoc i (vector-ref ___atable state))))
                              (vector-set! ___stack (- ___sp 1) #f)
                              (vector-set! ___stack ___sp (cadr act)))
                            (begin (___consume) (skip))))))))
                (define (___category tok)
                  (if (lexical-token? tok)
                    (lexical-token-category tok)
                    tok))
                (define (___run)
                  (let loop ()
                    (if ___input
                      (let* ((state (vector-ref ___stack ___sp))
                             (i (___category ___input))
                             (act (___action i (vector-ref ___atable state))))
                        (cond ((not (symbol? i))
                               (when ___errorp
                                     (___errorp
                                       'invalid-token
                                       "Syntax error: invalid token: ~s"
                                       ___input))
                               #f)
                              ((equal? act 'accept) (vector-ref ___stack 1))
                              ((equal? act '*error*)
                               (if (equal? i '*eoi*)
                                 (begin
                                   (when ___errorp
                                         (___errorp
                                           'end-of-input
                                           "Syntax error: unexpected end of input: ~s"
                                           ___input))
                                   #f)
                                 (begin
                                   (when ___errorp
                                         (___errorp
                                           'unexpected-token
                                           "Syntax error: unexpected token: ~s"
                                           ___input))
                                   (___recover i)
                                   (if (>= ___sp 0)
                                     (set! ___input #f)
                                     (begin
                                       (set! ___sp 0)
                                       (set! ___input '*eoi*)))
                                   (loop))))
                              ((>= act 0)
                               (___shift act ___input)
                               (set! ___input (if (equal? i '*eoi*) '*eoi* #f))
                               (loop))
                              (else (___reduce (- act)) (loop))))
                      (let* ((state (vector-ref ___stack ___sp))
                             (acts (vector-ref ___atable state))
                             (defact (if (pair? acts) (cadar acts) #f)))
                        (if (and (= 1 (length acts)) (< defact 0))
                          (___reduce (- defact))
                          (___consume))
                        (loop)))))
                (set! ___input #f)
                (set! ___reuse-input #f)
                (___initstack)
                (___run)))))
        (define code-actions #())
        (define maybefun (maybefun0 code-actions))
        (vector
          '*serialized-lalr-scm-parser*
          'first
          'lr-driver
          '(ID NUM
               =
               +
               -
               *
               /
               LPAREN
               RPAREN
               SPACE
               NEWLINE
               COMMA)
          '((expr (expr add expr)
                  :
                  #t
                  (LPAREN expr RPAREN)
                  :
                  #t
                  (term)
                  :
                  #t)
            (add (+) : #t)
            (term (NUM) : #t))
          code-actions
          '(let ()
             (define (cadar l) (car (cdr (car l))))
             (define (drop l n)
               (cond ((and (> n 0) (pair? l)) (drop (cdr l) (- n 1)))
                     (else l)))
             (define (take-right l n)
               (drop l (- (length l) n)))
             (define (note-source-location lvalue tok) lvalue)
             (define (lexical-token? x)
               (and (vector? x)
                    (= 4 (vector-length x))
                    (equal? (vector-ref x 0) '*lexical-token*)))
             (define (lexical-token-category x)
               (vector-ref x 1))
             (define (lexical-token-source x)
               (vector-ref x 2))
             (define (lexical-token-value x) (vector-ref x 3))
             (define action-table
               '#(((*default* *error*) (NUM 2) (LPAREN 1))
                  ((*default* *error*) (NUM 2) (LPAREN 1))
                  ((*default* -6))
                  ((*default* -4))
                  ((*default* *error*) (*eoi* 7) (+ 6))
                  ((*default* *error*) (+ 6) (RPAREN 9))
                  ((*default* -5))
                  ((*default* -1) (*eoi* accept))
                  ((*default* *error*) (NUM 2) (LPAREN 1))
                  ((*default* -3))
                  ((*default* -2) (+ 6))))
             (define goto-table
               (vector
                 '((3 . 3) (1 . 4))
                 '((3 . 3) (1 . 5))
                 '()
                 '()
                 '((2 . 8))
                 '((2 . 8))
                 '()
                 '()
                 '((3 . 3) (1 . 10))
                 '()
                 '((2 . 8))))
             (lambda (actions)
               (define (external index . args)
                 (apply (vector-ref actions index) args))
               (define reduction-table
                 (vector
                   '()
                   (lambda (___stack ___sp ___goto-table ___push yypushback)
                     (let* ((tok (vector-ref ___stack (- ___sp 1)))
                            ($2 (if (lexical-token? tok)
                                  (lexical-token-value tok)
                                  tok))
                            (@2 (if (lexical-token? tok)
                                  (lexical-token-source tok)
                                  tok))
                            (tok (vector-ref ___stack (- ___sp 3)))
                            ($1 (if (lexical-token? tok)
                                  (lexical-token-value tok)
                                  tok))
                            (@1 (if (lexical-token? tok)
                                  (lexical-token-source tok)
                                  tok)))
                       $1))
                   (lambda (___stack ___sp ___goto-table ___push yypushback)
                     (let* ((tok (vector-ref ___stack (- ___sp 1)))
                            ($3 (if (lexical-token? tok)
                                  (lexical-token-value tok)
                                  tok))
                            (@3 (if (lexical-token? tok)
                                  (lexical-token-source tok)
                                  tok))
                            (tok (vector-ref ___stack (- ___sp 3)))
                            ($2 (if (lexical-token? tok)
                                  (lexical-token-value tok)
                                  tok))
                            (@2 (if (lexical-token? tok)
                                  (lexical-token-source tok)
                                  tok))
                            (tok (vector-ref ___stack (- ___sp 5)))
                            ($1 (if (lexical-token? tok)
                                  (lexical-token-value tok)
                                  tok))
                            (@1 (if (lexical-token? tok)
                                  (lexical-token-source tok)
                                  tok)))
                       (___push
                         3
                         1
                         #t
                         (vector-ref ___stack (- ___sp 3)))))
                   (lambda (___stack ___sp ___goto-table ___push yypushback)
                     (let* ((tok (vector-ref ___stack (- ___sp 1)))
                            ($3 (if (lexical-token? tok)
                                  (lexical-token-value tok)
                                  tok))
                            (@3 (if (lexical-token? tok)
                                  (lexical-token-source tok)
                                  tok))
                            (tok (vector-ref ___stack (- ___sp 3)))
                            ($2 (if (lexical-token? tok)
                                  (lexical-token-value tok)
                                  tok))
                            (@2 (if (lexical-token? tok)
                                  (lexical-token-source tok)
                                  tok))
                            (tok (vector-ref ___stack (- ___sp 5)))
                            ($1 (if (lexical-token? tok)
                                  (lexical-token-value tok)
                                  tok))
                            (@1 (if (lexical-token? tok)
                                  (lexical-token-source tok)
                                  tok)))
                       (___push
                         3
                         1
                         #t
                         (vector-ref ___stack (- ___sp 3)))))
                   (lambda (___stack ___sp ___goto-table ___push yypushback)
                     (let* ((tok (vector-ref ___stack (- ___sp 1)))
                            ($1 (if (lexical-token? tok)
                                  (lexical-token-value tok)
                                  tok))
                            (@1 (if (lexical-token? tok)
                                  (lexical-token-source tok)
                                  tok)))
                       (___push
                         1
                         1
                         #t
                         (vector-ref ___stack (- ___sp 1)))))
                   (lambda (___stack ___sp ___goto-table ___push yypushback)
                     (let* ((tok (vector-ref ___stack (- ___sp 1)))
                            ($1 (if (lexical-token? tok)
                                  (lexical-token-value tok)
                                  tok))
                            (@1 (if (lexical-token? tok)
                                  (lexical-token-source tok)
                                  tok)))
                       (___push
                         1
                         2
                         #t
                         (vector-ref ___stack (- ___sp 1)))))
                   (lambda (___stack ___sp ___goto-table ___push yypushback)
                     (let* ((tok (vector-ref ___stack (- ___sp 1)))
                            ($1 (if (lexical-token? tok)
                                  (lexical-token-value tok)
                                  tok))
                            (@1 (if (lexical-token? tok)
                                  (lexical-token-source tok)
                                  tok)))
                       (___push
                         1
                         3
                         #t
                         (vector-ref ___stack (- ___sp 1)))))))
               (lambda (___scanner ___errorp)
                 (define get-next-token
                   (lambda args (___scanner)))
                 (define *initial-stack-size* 500)
                 (define ___atable action-table)
                 (define ___gtable goto-table)
                 (define ___rtable reduction-table)
                 (define ___stack #f)
                 (define ___sp 0)
                 (define ___curr-input #f)
                 (define ___reuse-input #f)
                 (define ___input #f)
                 (define (___consume)
                   (set! ___input
                     (if ___reuse-input
                       ___curr-input
                       (get-next-token)))
                   (set! ___reuse-input #f)
                   (set! ___curr-input ___input))
                 (define (___pushback) (set! ___reuse-input #t))
                 (define (___initstack)
                   (set! ___stack
                     (make-vector *initial-stack-size* 0))
                   (set! ___sp 0))
                 (define (___growstack)
                   (let ((new-stack
                           (make-vector (* 2 (vector-length ___stack)) 0)))
                     (let loop ((i (- (vector-length ___stack) 1)))
                       (if (>= i 0)
                         (begin
                           (vector-set! new-stack i (vector-ref ___stack i))
                           (loop (- i 1)))))
                     (set! ___stack new-stack)))
                 (define (___checkstack)
                   (if (>= ___sp (vector-length ___stack))
                     (___growstack)))
                 (define (___push delta new-category lvalue tok)
                   (set! ___sp (- ___sp (* delta 2)))
                   (let* ((state (vector-ref ___stack ___sp))
                          (new-state
                            (cdr (assoc new-category
                                        (vector-ref ___gtable state)))))
                     (set! ___sp (+ ___sp 2))
                     (___checkstack)
                     (vector-set! ___stack ___sp new-state)
                     (vector-set!
                       ___stack
                       (- ___sp 1)
                       (note-source-location lvalue tok))))
                 (define (___reduce st)
                   ((vector-ref ___rtable st)
                    ___stack
                    ___sp
                    ___gtable
                    ___push
                    ___pushback))
                 (define (___shift token attribute)
                   (set! ___sp (+ ___sp 2))
                   (___checkstack)
                   (vector-set! ___stack (- ___sp 1) attribute)
                   (vector-set! ___stack ___sp token))
                 (define (___action x l)
                   (let ((y (assoc x l))) (if y (cadr y) (cadar l))))
                 (define (___recover tok)
                   (let find-state ((sp ___sp))
                     (if (< sp 0)
                       (set! ___sp sp)
                       (let* ((state (vector-ref ___stack sp))
                              (act (assoc 'error
                                          (vector-ref ___atable state))))
                         (if act
                           (begin (set! ___sp sp) (___sync (cadr act) tok))
                           (find-state (- sp 2)))))))
                 (define (___sync state tok)
                   (let ((sync-set
                           (map car (cdr (vector-ref ___atable state)))))
                     (set! ___sp (+ ___sp 4))
                     (___checkstack)
                     (vector-set! ___stack (- ___sp 3) #f)
                     (vector-set! ___stack (- ___sp 2) state)
                     (let skip ()
                       (let ((i (___category ___input)))
                         (if (equal? i '*eoi*)
                           (set! ___sp -1)
                           (if (memq i sync-set)
                             (let ((act (assoc i
                                               (vector-ref ___atable state))))
                               (vector-set! ___stack (- ___sp 1) #f)
                               (vector-set! ___stack ___sp (cadr act)))
                             (begin (___consume) (skip))))))))
                 (define (___category tok)
                   (if (lexical-token? tok)
                     (lexical-token-category tok)
                     tok))
                 (define (___run)
                   (let loop ()
                     (if ___input
                       (let* ((state (vector-ref ___stack ___sp))
                              (i (___category ___input))
                              (act (___action i (vector-ref ___atable state))))
                         (cond ((not (symbol? i))
                                (when ___errorp
                                      (___errorp
                                        'invalid-token
                                        "Syntax error: invalid token: ~s"
                                        ___input))
                                #f)
                               ((equal? act 'accept) (vector-ref ___stack 1))
                               ((equal? act '*error*)
                                (if (equal? i '*eoi*)
                                  (begin
                                    (when ___errorp
                                          (___errorp
                                            'end-of-input
                                            "Syntax error: unexpected end of input: ~s"
                                            ___input))
                                    #f)
                                  (begin
                                    (when ___errorp
                                          (___errorp
                                            'unexpected-token
                                            "Syntax error: unexpected token: ~s"
                                            ___input))
                                    (___recover i)
                                    (if (>= ___sp 0)
                                      (set! ___input #f)
                                      (begin
                                        (set! ___sp 0)
                                        (set! ___input '*eoi*)))
                                    (loop))))
                               ((>= act 0)
                                (___shift act ___input)
                                (set! ___input
                                  (if (equal? i '*eoi*) '*eoi* #f))
                                (loop))
                               (else (___reduce (- act)) (loop))))
                       (let* ((state (vector-ref ___stack ___sp))
                              (acts (vector-ref ___atable state))
                              (defact (if (pair? acts) (cadar acts) #f)))
                         (if (and (= 1 (length acts)) (< defact 0))
                           (___reduce (- defact))
                           (___consume))
                         (loop)))))
                 (set! ___input #f)
                 (set! ___reuse-input #f)
                 (___initstack)
                 (___run))))
          maybefun)))))

