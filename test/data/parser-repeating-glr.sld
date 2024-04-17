(define-library
  (data parser-repeating-glr)
  (export parser-repeating-glr)
  (import (scheme base))
  (begin
    (define parser-repeating-glr
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
            (define (token? x)
              (and (vector? x)
                   (= 4 (vector-length x))
                   (equal? (vector-ref x 0) '*lexical-token*)))
            (define (token-category x) (vector-ref x 1))
            (define (token-source x) (vector-ref x 2))
            (define (token-value x) (vector-ref x 3))
            (define (token-category/soft x)
              (if (token? x) (token-category x) x))
            (define (token-source/soft x)
              (if (token? x) (token-source x) x))
            (define (token-value/soft x)
              (if (token? x) (token-value x) x))
            (define action-table
              '#(((*default* *error*) (NUM 1))
                 ((*default* -5))
                 ((*default* -3))
                 ((*default* *error*) (*eoi* 5) (+ 4))
                 ((*default* -4))
                 ((*default* -1) (*eoi* accept))
                 ((*default* *error*) (NUM 1))
                 ((*default* -2) (+ -2 4))))
            (define goto-table
              (vector
                '((3 . 2) (1 . 3))
                '()
                '()
                '((2 . 6))
                '()
                '()
                '((3 . 2) (1 . 7))
                '((2 . 6))))
            (lambda (actions)
              (define (external index . args)
                (apply (vector-ref actions index) args))
              (define reduction-table
                (vector
                  '()
                  (lambda (___sp ___goto-table ___push)
                    (let* ((tok (list-ref ___sp 1))
                           ($2 (token-value/soft tok))
                           (@2 (token-source/soft tok))
                           (tok (list-ref ___sp 3))
                           ($1 (token-value/soft tok))
                           (@1 (token-source/soft tok)))
                      $1))
                  (lambda (___sp ___goto-table ___push)
                    (let* ((tok (list-ref ___sp 1))
                           ($3 (token-value/soft tok))
                           (@3 (token-source/soft tok))
                           (tok (list-ref ___sp 3))
                           ($2 (token-value/soft tok))
                           (@2 (token-source/soft tok))
                           (tok (list-ref ___sp 5))
                           ($1 (token-value/soft tok))
                           (@1 (token-source/soft tok)))
                      (___push 3 1 #t ___sp (list-ref ___sp 3))))
                  (lambda (___sp ___goto-table ___push)
                    (let* ((tok (list-ref ___sp 1))
                           ($1 (token-value/soft tok))
                           (@1 (token-source/soft tok)))
                      (___push 1 1 #t ___sp (list-ref ___sp 1))))
                  (lambda (___sp ___goto-table ___push)
                    (let* ((tok (list-ref ___sp 1))
                           ($1 (token-value/soft tok))
                           (@1 (token-source/soft tok)))
                      (___push 1 2 #t ___sp (list-ref ___sp 1))))
                  (lambda (___sp ___goto-table ___push)
                    (let* ((tok (list-ref ___sp 1))
                           ($1 (token-value/soft tok))
                           (@1 (token-source/soft tok)))
                      (___push 1 3 #t ___sp (list-ref ___sp 1))))))
              (lambda (___scanner ___errorp)
                (define get-next-token
                  (lambda args (___scanner)))
                (define ___atable action-table)
                (define ___gtable goto-table)
                (define ___rtable reduction-table)
                (define (consume) (get-next-token))
                (define *processes* '())
                (define (initialize-processes)
                  (set! *processes* '()))
                (define (add-process! process)
                  (set! *processes* (cons process *processes*)))
                (define (get-processes) (reverse *processes*))
                (define (push delta new-category lvalue stack tok)
                  (let* ((stack (drop stack (* delta 2)))
                         (state (car stack))
                         (new-state
                           (cdr (assv new-category
                                      (vector-ref ___gtable state)))))
                    (cons new-state
                          (cons (note-source-location lvalue tok) stack))))
                (define (reduce state stack)
                  ((vector-ref ___rtable state)
                   stack
                   ___gtable
                   push))
                (define (shift state symbol stack)
                  (cons state (cons symbol stack)))
                (define (get-actions token action-list)
                  (let ((pair (assoc token action-list)))
                    (if pair (cdr pair) (cdar action-list))))
                (define s_routine 'run)
                (define s_input #f)
                (define s_symbol #f)
                (define s_processes #f)
                (define s_stacks #f)
                (define s_active-stacks #f)
                (define s_stack #f)
                (define s_actions #f)
                (define (save-loop-state!
                         routine
                         *input*
                         symbol
                         processes
                         stacks
                         active-stacks
                         stack
                         actions)
                  (set! s_routine routine)
                  (set! s_input *input*)
                  (set! s_symbol symbol)
                  (set! s_processes processes)
                  (set! s_stacks stacks)
                  (set! s_active-stacks active-stacks)
                  (set! s_stack stack)
                  (set! s_actions actions))
                (define (continue
                         routine
                         *input*
                         symbol
                         processes
                         stacks
                         active-stacks
                         stack
                         actions)
                  (case routine
                    ((run) (run))
                    ((run-processes)
                     (run-processes *input* symbol processes))
                    ((run-single-process)
                     (run-single-process
                       *input*
                       symbol
                       processes
                       stacks
                       active-stacks))
                    ((run-actions-loop)
                     (run-actions-loop
                       *input*
                       symbol
                       processes
                       stacks
                       active-stacks
                       stack
                       actions))
                    ((done) #f)
                    (else 'TODO (+ 1 routine) (/ 1 0))))
                (define (continue-from-saved)
                  (continue
                    s_routine
                    s_input
                    s_symbol
                    s_processes
                    s_stacks
                    s_active-stacks
                    s_stack
                    s_actions))
                (define (run-actions-loop
                         *input*
                         symbol
                         processes
                         stacks
                         active-stacks
                         stack
                         actions)
                  (let actions-loop ((actions actions)
                                     (active-stacks active-stacks))
                    (if (pair? actions)
                      (let ((action (car actions))
                            (other-actions (cdr actions)))
                        (cond ((equal? action '*error*)
                               (actions-loop other-actions active-stacks))
                              ((equal? action 'accept)
                               (let ((actions other-actions))
                                 (save-loop-state!
                                   'run-actions-loop
                                   *input*
                                   symbol
                                   processes
                                   stacks
                                   active-stacks
                                   stack
                                   actions))
                               (let ((result (car (take-right stack 2))))
                                 result))
                              ((>= action 0)
                               (let ((new-stack (shift action *input* stack)))
                                 (add-process! new-stack))
                               (actions-loop other-actions active-stacks))
                              (else
                               (let ((new-stack (reduce (- action) stack)))
                                 (actions-loop
                                   other-actions
                                   (cons new-stack active-stacks))))))
                      (continue
                        'run-single-process
                        *input*
                        symbol
                        processes
                        (cdr stacks)
                        active-stacks
                        #f
                        #f))))
                (define (run-single-process
                         *input*
                         symbol
                         processes
                         stacks
                         active-stacks)
                  (let loop ((stacks stacks) (active-stacks active-stacks))
                    (cond ((pair? stacks)
                           (let ()
                             (define stack (car stacks))
                             (define state (car stack))
                             (define actions
                               (get-actions
                                 symbol
                                 (vector-ref ___atable state)))
                             (run-actions-loop
                               *input*
                               symbol
                               processes
                               stacks
                               active-stacks
                               stack
                               actions)))
                          ((pair? active-stacks)
                           (continue
                             'run-single-process
                             *input*
                             symbol
                             processes
                             (reverse active-stacks)
                             '()
                             #f
                             #f))
                          (else
                           (continue
                             'run-processes
                             *input*
                             symbol
                             (cdr processes)
                             #f
                             #f
                             #f
                             #f)))))
                (define (run-processes *input* symbol processes)
                  (let loop ((processes processes))
                    (if (null? processes)
                      (if (pair? (get-processes))
                        (continue 'run #f #f #f #f #f #f #f)
                        (continue 'done #f #f #f #f #f #f #f))
                      (continue
                        'run-single-process
                        *input*
                        symbol
                        processes
                        (list (car processes))
                        '()
                        #f
                        #f))))
                (define (run)
                  (let loop-tokens ()
                    (define *input* (consume))
                    (define symbol (token-category/soft *input*))
                    (define processes (get-processes))
                    (initialize-processes)
                    (continue
                      'run-processes
                      *input*
                      symbol
                      processes
                      #f
                      #f
                      #f
                      #f)))
                (define (init)
                  (initialize-processes)
                  (save-loop-state! 'run #f #f #f #f #f #f #f)
                  (add-process! '(0)))
                (define (make-iterator)
                  (init)
                  (lambda _ (continue-from-saved)))
                (define (make-first-returner)
                  (init)
                  (continue-from-saved))
                (make-iterator)))))
        (define code-actions #())
        (define maybefun (maybefun0 code-actions))
        (vector
          '*serialized-lalr-scm-parser*
          'all
          'glr-driver
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
          '((expr (expr add expr) : #t (term) : #t)
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
             (define (token? x)
               (and (vector? x)
                    (= 4 (vector-length x))
                    (equal? (vector-ref x 0) '*lexical-token*)))
             (define (token-category x) (vector-ref x 1))
             (define (token-source x) (vector-ref x 2))
             (define (token-value x) (vector-ref x 3))
             (define (token-category/soft x)
               (if (token? x) (token-category x) x))
             (define (token-source/soft x)
               (if (token? x) (token-source x) x))
             (define (token-value/soft x)
               (if (token? x) (token-value x) x))
             (define action-table
               '#(((*default* *error*) (NUM 1))
                  ((*default* -5))
                  ((*default* -3))
                  ((*default* *error*) (*eoi* 5) (+ 4))
                  ((*default* -4))
                  ((*default* -1) (*eoi* accept))
                  ((*default* *error*) (NUM 1))
                  ((*default* -2) (+ -2 4))))
             (define goto-table
               (vector
                 '((3 . 2) (1 . 3))
                 '()
                 '()
                 '((2 . 6))
                 '()
                 '()
                 '((3 . 2) (1 . 7))
                 '((2 . 6))))
             (lambda (actions)
               (define (external index . args)
                 (apply (vector-ref actions index) args))
               (define reduction-table
                 (vector
                   '()
                   (lambda (___sp ___goto-table ___push)
                     (let* ((tok (list-ref ___sp 1))
                            ($2 (token-value/soft tok))
                            (@2 (token-source/soft tok))
                            (tok (list-ref ___sp 3))
                            ($1 (token-value/soft tok))
                            (@1 (token-source/soft tok)))
                       $1))
                   (lambda (___sp ___goto-table ___push)
                     (let* ((tok (list-ref ___sp 1))
                            ($3 (token-value/soft tok))
                            (@3 (token-source/soft tok))
                            (tok (list-ref ___sp 3))
                            ($2 (token-value/soft tok))
                            (@2 (token-source/soft tok))
                            (tok (list-ref ___sp 5))
                            ($1 (token-value/soft tok))
                            (@1 (token-source/soft tok)))
                       (___push 3 1 #t ___sp (list-ref ___sp 3))))
                   (lambda (___sp ___goto-table ___push)
                     (let* ((tok (list-ref ___sp 1))
                            ($1 (token-value/soft tok))
                            (@1 (token-source/soft tok)))
                       (___push 1 1 #t ___sp (list-ref ___sp 1))))
                   (lambda (___sp ___goto-table ___push)
                     (let* ((tok (list-ref ___sp 1))
                            ($1 (token-value/soft tok))
                            (@1 (token-source/soft tok)))
                       (___push 1 2 #t ___sp (list-ref ___sp 1))))
                   (lambda (___sp ___goto-table ___push)
                     (let* ((tok (list-ref ___sp 1))
                            ($1 (token-value/soft tok))
                            (@1 (token-source/soft tok)))
                       (___push 1 3 #t ___sp (list-ref ___sp 1))))))
               (lambda (___scanner ___errorp)
                 (define get-next-token
                   (lambda args (___scanner)))
                 (define ___atable action-table)
                 (define ___gtable goto-table)
                 (define ___rtable reduction-table)
                 (define (consume) (get-next-token))
                 (define *processes* '())
                 (define (initialize-processes)
                   (set! *processes* '()))
                 (define (add-process! process)
                   (set! *processes* (cons process *processes*)))
                 (define (get-processes) (reverse *processes*))
                 (define (push delta new-category lvalue stack tok)
                   (let* ((stack (drop stack (* delta 2)))
                          (state (car stack))
                          (new-state
                            (cdr (assv new-category
                                       (vector-ref ___gtable state)))))
                     (cons new-state
                           (cons (note-source-location lvalue tok) stack))))
                 (define (reduce state stack)
                   ((vector-ref ___rtable state)
                    stack
                    ___gtable
                    push))
                 (define (shift state symbol stack)
                   (cons state (cons symbol stack)))
                 (define (get-actions token action-list)
                   (let ((pair (assoc token action-list)))
                     (if pair (cdr pair) (cdar action-list))))
                 (define s_routine 'run)
                 (define s_input #f)
                 (define s_symbol #f)
                 (define s_processes #f)
                 (define s_stacks #f)
                 (define s_active-stacks #f)
                 (define s_stack #f)
                 (define s_actions #f)
                 (define (save-loop-state!
                          routine
                          *input*
                          symbol
                          processes
                          stacks
                          active-stacks
                          stack
                          actions)
                   (set! s_routine routine)
                   (set! s_input *input*)
                   (set! s_symbol symbol)
                   (set! s_processes processes)
                   (set! s_stacks stacks)
                   (set! s_active-stacks active-stacks)
                   (set! s_stack stack)
                   (set! s_actions actions))
                 (define (continue
                          routine
                          *input*
                          symbol
                          processes
                          stacks
                          active-stacks
                          stack
                          actions)
                   (case routine
                     ((run) (run))
                     ((run-processes)
                      (run-processes *input* symbol processes))
                     ((run-single-process)
                      (run-single-process
                        *input*
                        symbol
                        processes
                        stacks
                        active-stacks))
                     ((run-actions-loop)
                      (run-actions-loop
                        *input*
                        symbol
                        processes
                        stacks
                        active-stacks
                        stack
                        actions))
                     ((done) #f)
                     (else 'TODO (+ 1 routine) (/ 1 0))))
                 (define (continue-from-saved)
                   (continue
                     s_routine
                     s_input
                     s_symbol
                     s_processes
                     s_stacks
                     s_active-stacks
                     s_stack
                     s_actions))
                 (define (run-actions-loop
                          *input*
                          symbol
                          processes
                          stacks
                          active-stacks
                          stack
                          actions)
                   (let actions-loop ((actions actions)
                                      (active-stacks active-stacks))
                     (if (pair? actions)
                       (let ((action (car actions))
                             (other-actions (cdr actions)))
                         (cond ((equal? action '*error*)
                                (actions-loop other-actions active-stacks))
                               ((equal? action 'accept)
                                (let ((actions other-actions))
                                  (save-loop-state!
                                    'run-actions-loop
                                    *input*
                                    symbol
                                    processes
                                    stacks
                                    active-stacks
                                    stack
                                    actions))
                                (let ((result (car (take-right stack 2))))
                                  result))
                               ((>= action 0)
                                (let ((new-stack (shift action *input* stack)))
                                  (add-process! new-stack))
                                (actions-loop other-actions active-stacks))
                               (else
                                (let ((new-stack (reduce (- action) stack)))
                                  (actions-loop
                                    other-actions
                                    (cons new-stack active-stacks))))))
                       (continue
                         'run-single-process
                         *input*
                         symbol
                         processes
                         (cdr stacks)
                         active-stacks
                         #f
                         #f))))
                 (define (run-single-process
                          *input*
                          symbol
                          processes
                          stacks
                          active-stacks)
                   (let loop ((stacks stacks) (active-stacks active-stacks))
                     (cond ((pair? stacks)
                            (let ()
                              (define stack (car stacks))
                              (define state (car stack))
                              (define actions
                                (get-actions
                                  symbol
                                  (vector-ref ___atable state)))
                              (run-actions-loop
                                *input*
                                symbol
                                processes
                                stacks
                                active-stacks
                                stack
                                actions)))
                           ((pair? active-stacks)
                            (continue
                              'run-single-process
                              *input*
                              symbol
                              processes
                              (reverse active-stacks)
                              '()
                              #f
                              #f))
                           (else
                            (continue
                              'run-processes
                              *input*
                              symbol
                              (cdr processes)
                              #f
                              #f
                              #f
                              #f)))))
                 (define (run-processes *input* symbol processes)
                   (let loop ((processes processes))
                     (if (null? processes)
                       (if (pair? (get-processes))
                         (continue 'run #f #f #f #f #f #f #f)
                         (continue 'done #f #f #f #f #f #f #f))
                       (continue
                         'run-single-process
                         *input*
                         symbol
                         processes
                         (list (car processes))
                         '()
                         #f
                         #f))))
                 (define (run)
                   (let loop-tokens ()
                     (define *input* (consume))
                     (define symbol (token-category/soft *input*))
                     (define processes (get-processes))
                     (initialize-processes)
                     (continue
                       'run-processes
                       *input*
                       symbol
                       processes
                       #f
                       #f
                       #f
                       #f)))
                 (define (init)
                   (initialize-processes)
                   (save-loop-state! 'run #f #f #f #f #f #f #f)
                   (add-process! '(0)))
                 (define (make-iterator)
                   (init)
                   (lambda _ (continue-from-saved)))
                 (define (make-first-returner)
                   (init)
                   (continue-from-saved))
                 (make-iterator))))
          maybefun)))))

