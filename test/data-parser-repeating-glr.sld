(define-library (data-parser-repeating-glr) (export data-parser-repeating-glr) (import (scheme base)) (begin let () (define (cadar l) (car (cdr (car l)))) (define (drop l n) (cond ((and (> n 0) (pair? l)) (drop (cdr l) (- n 1))) (else l))) (define (take-right l n) (drop l (- (length l) n))) (define (note-source-location lvalue tok) lvalue) (define (lexical-token? x) (and (vector? x) (= 4 (vector-length x)) (eq? (vector-ref x 0) (quote *lexical-token*)))) (define (lexical-token-category x) (vector-ref x 1)) (define (lexical-token-source x) (vector-ref x 2)) (define (lexical-token-value x) (vector-ref x 3)) (define action-table (quote #(((*default* *error*) (NUM 1)) ((*default* -5)) ((*default* -3)) ((*default* *error*) (*eoi* 5) (+ 4)) ((*default* -4)) ((*default* -1) (*eoi* accept)) ((*default* *error*) (NUM 1)) ((*default* -2) (+ -2 4))))) (define goto-table (vector (quote ((3 . 2) (1 . 3))) (quote ()) (quote ()) (quote ((2 . 6))) (quote ()) (quote ()) (quote ((3 . 2) (1 . 7))) (quote ((2 . 6))))) (lambda (actions) (define (external index . args) (apply (vector-ref actions index) args)) (define reduction-table (vector (quote ()) (lambda (___sp ___goto-table ___push) (let* ((tok (list-ref ___sp 1)) ($2 (if (lexical-token? tok) (lexical-token-value tok) tok)) (@2 (if (lexical-token? tok) (lexical-token-source tok) tok)) (tok (list-ref ___sp 3)) ($1 (if (lexical-token? tok) (lexical-token-value tok) tok)) (@1 (if (lexical-token? tok) (lexical-token-source tok) tok))) $1)) (lambda (___sp ___goto-table ___push) (let* ((tok (list-ref ___sp 1)) ($3 (if (lexical-token? tok) (lexical-token-value tok) tok)) (@3 (if (lexical-token? tok) (lexical-token-source tok) tok)) (tok (list-ref ___sp 3)) ($2 (if (lexical-token? tok) (lexical-token-value tok) tok)) (@2 (if (lexical-token? tok) (lexical-token-source tok) tok)) (tok (list-ref ___sp 5)) ($1 (if (lexical-token? tok) (lexical-token-value tok) tok)) (@1 (if (lexical-token? tok) (lexical-token-source tok) tok))) (___push 3 1 #t ___sp (list-ref ___sp 3)))) (lambda (___sp ___goto-table ___push) (let* ((tok (list-ref ___sp 1)) ($1 (if (lexical-token? tok) (lexical-token-value tok) tok)) (@1 (if (lexical-token? tok) (lexical-token-source tok) tok))) (___push 1 1 #t ___sp (list-ref ___sp 1)))) (lambda (___sp ___goto-table ___push) (let* ((tok (list-ref ___sp 1)) ($1 (if (lexical-token? tok) (lexical-token-value tok) tok)) (@1 (if (lexical-token? tok) (lexical-token-source tok) tok))) (___push 1 2 #t ___sp (list-ref ___sp 1)))) (lambda (___sp ___goto-table ___push) (let* ((tok (list-ref ___sp 1)) ($1 (if (lexical-token? tok) (lexical-token-value tok) tok)) (@1 (if (lexical-token? tok) (lexical-token-source tok) tok))) (___push 1 3 #t ___sp (list-ref ___sp 1)))))) (define ___atable action-table) (define ___gtable goto-table) (define ___rtable reduction-table) (define ___lexerp #f) (define ___errorp #f) (define *input* #f) (define (initialize-lexer lexer) (set! ___lexerp lexer) (set! *input* #f)) (define (consume) (set! *input* (___lexerp))) (define (token-category tok) (if (lexical-token? tok) (lexical-token-category tok) tok)) (define (token-attribute tok) (if (lexical-token? tok) (lexical-token-value tok) tok)) (define *processes* (quote ())) (define (initialize-processes) (set! *processes* (quote ()))) (define (add-process process) (set! *processes* (cons process *processes*))) (define (get-processes) (reverse *processes*)) (define (for-all-processes proc) (let ((processes (get-processes))) (initialize-processes) (for-each proc processes))) (define *parses* (quote ())) (define (get-parses) *parses*) (define (initialize-parses) (set! *parses* (quote ()))) (define (add-parse parse) (set! *parses* (cons parse *parses*))) (define (push delta new-category lvalue stack tok) (let* ((stack (drop stack (* delta 2))) (state (car stack)) (new-state (cdr (assv new-category (vector-ref ___gtable state))))) (cons new-state (cons (note-source-location lvalue tok) stack)))) (define (reduce state stack) ((vector-ref ___rtable state) stack ___gtable push)) (define (shift state symbol stack) (cons state (cons symbol stack))) (define (get-actions token action-list) (let ((pair (assoc token action-list))) (if pair (cdr pair) (cdar action-list)))) (define (run) (let loop-tokens () (consume) (let ((symbol (token-category *input*))) (for-all-processes (lambda (process) (let loop ((stacks (list process)) (active-stacks (quote ()))) (cond ((pair? stacks) (let* ((stack (car stacks)) (state (car stack))) (let actions-loop ((actions (get-actions symbol (vector-ref ___atable state))) (active-stacks active-stacks)) (if (pair? actions) (let ((action (car actions)) (other-actions (cdr actions))) (cond ((eq? action (quote *error*)) (actions-loop other-actions active-stacks)) ((eq? action (quote accept)) (add-parse (car (take-right stack 2))) (actions-loop other-actions active-stacks)) ((>= action 0) (let ((new-stack (shift action *input* stack))) (add-process new-stack)) (actions-loop other-actions active-stacks)) (else (let ((new-stack (reduce (- action) stack))) (actions-loop other-actions (cons new-stack active-stacks)))))) (loop (cdr stacks) active-stacks))))) ((pair? active-stacks) (loop (reverse active-stacks) (quote ())))))))) (if (pair? (get-processes)) (loop-tokens)))) (lambda (lexerp errorp) (set! ___errorp errorp) (initialize-lexer lexerp) (initialize-processes) (initialize-parses) (add-process (quote (0))) (run) (get-parses)))))
