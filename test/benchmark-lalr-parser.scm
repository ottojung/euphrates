
;;
;; this file is like test-lalr-parser-largecases.scm, but cases are even larger
;;

(define (make-repeating-lexer for-how-long repeating-tokens)
  (define buf repeating-tokens)
  (define i for-how-long)

  (define (next)
    (cond
     ((null? buf)
      (set! buf repeating-tokens)
      (next))
     ((< i 1) '*eoi*)
     (else
      (let ((t (car buf)))
        (set! buf (cdr buf))
        (set! i (- i 1))
        t))))

  (when (null? repeating-tokens)
    (raisu 'bad-repeating-tokens repeating-tokens))

  (lambda () (next)))

(define (make-brackets-lexer how-deep)
  (define i 0)
  (define maxdepth 0)
  (define closecount 0)
  (define cycle-tokens #(LPAREN NUM +))
  (define cycle-values #("(" "5" "+"))
  (define final 'NUM)

  (define (next)
    (define imod (modulo i (vector-length cycle-tokens)))
    (define t (vector-ref cycle-tokens imod))
    (define v (vector-ref cycle-values imod))
    (set! i (+ 1 i))

    (cond
     ((< maxdepth how-deep)
      (when (equal? t 'LPAREN)
        (set! maxdepth (+ maxdepth 1)))
      (make-lexical-token t #f v))
     ((> maxdepth how-deep)
      (if (< (+ 1 closecount) maxdepth)
          (begin
            (set! closecount (+ closecount 1))
            (make-lexical-token 'RPAREN #f ")"))
          '*eoi*))
     (else
      (if (equal? t 'LPAREN)
          (begin
            (set! maxdepth (+ maxdepth 1))
            (make-lexical-token 'NUM #f "1"))
          (make-lexical-token t #f v)))))

  (lambda () (next)))

(define save (const #t))

;;;;;;;;;;;;
;;
;; START
;;

(with-benchmark/simple
 :name "benchmark-lalr-parser-1"
 :inputs ((seq-len 299999))

 (define parser
   (lalr-parser
    `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
      (rules:
       (expr     (expr add expr) : (,save $1 $2 $3)
                 (term) : (,save $1))
       (add      (+) : (,save $1))
       (term     (NUM) : (,save $1))))))

 (define (error-procedure type message-fmt token)
   (raisu* :type 'parse-error
           :message (stringf message-fmt token)
           :args (list type token)))

 (define result
   (parser (make-repeating-lexer
            seq-len
            (list (make-lexical-token 'NUM #f "5")
                  (make-lexical-token '+ #f "+")))
           error-procedure))

 (assert= #t result))







(with-benchmark/simple
 :name "benchmark-lalr-parser-2"
 :inputs ((seq-len 23))

 (define parser
   (lalr-parser
    `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
      (driver: glr)
      (on-conflict: ,ignore)
      (rules:
       (expr     (expr add expr) : (,save $1 $2 $3)
                 (term) : (,save $1))
       (add      (+) : (,save $1))
       (term     (NUM) : (,save $1))))))

 (define (error-procedure type message-fmt token)
   (raisu* :type 'parse-error
           :message (stringf message-fmt token)
           :args (list type token)))

 (define result
   (parser (make-repeating-lexer
            seq-len
            (list (make-lexical-token 'NUM #f "5")
                  (make-lexical-token '+ #f "+")))
           error-procedure))

 (assert (list? result))
 (assert (not (null? result))))








(with-benchmark/simple
 :name "benchmark-lalr-parser-3"
 :inputs ((tree-depth 50000))

 (define parser
   (lalr-parser
    `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
      (rules:
       (expr     (expr add expr) : (,save 'expr $1 $2 $3)
                 (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
                 (term) : (,save 'expr $1))
       (add      (+) : (,save 'add $1))
       (term     (NUM) : (,save 'term $1))))))

 (define (error-procedure type message-fmt token)
   (raisu* :type 'parse-error
           :message (stringf message-fmt token)
           :args (list type token)))

 (define result
   (parser (make-brackets-lexer tree-depth) error-procedure))

 (assert= #t result))





(with-benchmark/simple
 :name "benchmark-lalr-parser-4"
 :inputs ((tree-depth 50000))

 (define parser
   (lalr-parser
    `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
      (driver: glr)
      (on-conflict: ,ignore)
      (rules:
       (expr     (expr add expr) : (,save 'expr $1 $2 $3)
                 (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
                 (term) : (,save 'expr $1))
       (add      (+) : (,save 'add $1))
       (term     (NUM) : (,save 'term $1))))))

 (define (error-procedure type message-fmt token)
   (raisu* :type 'parse-error
           :message (stringf message-fmt token)
           :args (list type token)))

 (define result
   (parser (make-brackets-lexer tree-depth) error-procedure))

 (assert (list? result))
 (assert (not (null? result))))
