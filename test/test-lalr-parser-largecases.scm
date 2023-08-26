
(define (make-lexer)
  (lambda ()
    (letrec ((read-number
              (lambda (l)
                (let ((c (peek-char)))
                  (if (and (char? c) (char-numeric? c))
                      (read-number (cons (read-char) l))
                      (string->number (apply string (reverse l)))))))
             (read-id
              (lambda (l)
                (let ((c (peek-char)))
                  (if (and (char? c)
                           (or (char-alphabetic? c)
                               (char-numeric? c)))
                      (read-id (cons (read-char) l))
                      (apply string (reverse l)))))))

      ;; -- read the next token
      (let loop ()
        (let* ((location (make-source-location "*stdin*" 'unknown-line 'unknown-column -1 -1))
               (c (read-char)))
          (cond ((eof-object? c)      '*eoi*)
                ((char=? c #\newline) (make-lexical-token 'NEWLINE location 'NEWLINE))
                ((char-whitespace? c) (make-lexical-token 'SPACE   location 'SPACE))
                ((char=? c #\+)       (make-lexical-token '+       location (string c)))
                ((char=? c #\-)       (make-lexical-token '-       location (string c)))
                ((char=? c #\*)       (make-lexical-token '*       location (string c)))
                ((char=? c #\/)       (make-lexical-token '/       location (string c)))
                ((char=? c #\=)       (make-lexical-token '=       location (string c)))
                ((char=? c #\,)       (make-lexical-token 'COMMA   location (string c)))
                ((char=? c #\()       (make-lexical-token 'LPAREN  location (string c)))
                ((char=? c #\))       (make-lexical-token 'RPAREN  location (string c)))
                ((char-numeric? c)    (make-lexical-token 'NUM     location (read-number (list c))))
                ((char-alphabetic? c) (make-lexical-token 'ID      location (read-id (list c))))
                (else
                 (raisu
                  'lex-error
                  (stringf "PARSE ERROR : illegal character: ~s" c)
                  c)
                 (loop))))))))

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
;; Sanity check
;;

(assert= "(5+(5+(5+(5+(5+1)))))"
         (with-output-stringified
          (define lexer (make-brackets-lexer 5))
          (let loop ()
            (define t (lexer))
            (unless (equal? '*eoi* t)
              (display (lexical-token-value t))
              (loop)))))

(let ()
  (define parser
    (lalr-parser
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add expr) : (,save $1 $2 $3)
                  (term) : (,save $1))
        (add      (+) : (,save $1))
        (term     (NUM) : (,save $1))))))

  (define result
    (with-string-as-input
     "5+3" (lalr-parser-run parser (make-lexer))))

  (assert= #t result))





(let ()
  (define parser
    (lalr-parser
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add expr) : (,save $1 $2 $3)
                  (term) : (,save $1))
        (add      (+) : (,save $1))
        (term     (NUM) : (,save $1))))))

  (define error-procedure ignore)

  (define result
    (with-string-as-input
     "5++" (lalr-parser-run/with-error-handler
            parser error-procedure (make-lexer))))

  (assert= #f result))




(let ()
  (define parser
    (lalr-parser
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add expr) : (,save $1 $2 $3)
                  (term) : (,save $1))
        (add      (+) : (,save $1))
        (term     (NUM) : (,save $1))))))

  (define result
    (lalr-parser-run
     parser
     (make-repeating-lexer
      3 (list (make-lexical-token 'NUM #f "5")
              (make-lexical-token '+ #f "+")
              (make-lexical-token 'NUM #f "3")))))

  (assert= #t result))




(let ()
  (define parser
    (lalr-parser
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add expr) : (,save $1 $2 $3)
                  (term) : (,save $1))
        (add      (+) : (,save $1))
        (term     (NUM) : (,save $1))))))

  (define result
    (lalr-parser-run
     parser
     (make-repeating-lexer
      9 (list (make-lexical-token 'NUM #f "5")
              (make-lexical-token '+ #f "+")))))

  (assert= #t result))




(let ()
  (define parser
    (lalr-parser
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add expr) : (,save $1 $2 $3)
                  (term) : (,save $1))
        (add      (+) : (,save $1))
        (term     (NUM) : (,save $1))))))

  (define error-procedure ignore)

  (define result
    (lalr-parser-run/with-error-handler
     parser
     error-procedure
     (make-repeating-lexer
      3 (list (make-lexical-token 'NUM #f "5")
              (make-lexical-token '+ #f "+")
              (make-lexical-token '+ #f "+")))))

  (assert= #f result))




(let ()
  (define parser
    (lalr-parser
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (driver: glr)
       (results: all)
       (on-conflict: ,ignore)
       (rules:
        (expr     (expr add expr) : (,save $1 $2 $3)
                  (term) : (,save $1))
        (add      (+) : (,save $1))
        (term     (NUM) : (,save $1))))))

  (define result
    (lalr-parser-run
     parser
     (make-repeating-lexer
      5 (list (make-lexical-token 'NUM #f "5")
              (make-lexical-token '+ #f "+")))))

  (assert (procedure? result))
  (assert (result 'get)))




(let ()
  (define parser
    (lalr-parser
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add expr) : (,save 'expr $1 $2 $3)
                  (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
                  (term) : (,save 'expr $1))
        (add      (+) : (,save 'add $1))
        (term     (NUM) : (,save 'term $1))))))

  (define result
    (lalr-parser-run
     parser (make-brackets-lexer 3)))

  (assert= #t result))





(let ()
  (define parser
    (lalr-parser
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (driver: glr)
       (results: all)
       (on-conflict: ,ignore)
       (rules:
        (expr     (expr add expr) : (,save 'expr $1 $2 $3)
                  (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
                  (term) : (,save 'expr $1))
        (add      (+) : (,save 'add $1))
        (term     (NUM) : (,save 'term $1))))))

  (define result
    (lalr-parser-run
     parser (make-brackets-lexer 3)))

  (assert (procedure? result))
  (assert (result 'get)))



;;;;;;;;;;;;;;;;;;
;;
;; Actual large tests
;;

(define (run-cases
         t1-input-size
         t2-input-size
         t3-input-size
         t4-input-size)


  (let ()
    (define parser
      (lalr-parser
       `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
         (rules:
          (expr     (expr add expr) : (,save $1 $2 $3)
                    (term) : (,save $1))
          (add      (+) : (,save $1))
          (term     (NUM) : (,save $1))))))

    (define result
      (lalr-parser-run
       parser
       (make-repeating-lexer
        t1-input-size
        (list (make-lexical-token 'NUM #f "5")
              (make-lexical-token '+ #f "+")))))

    (assert= #t result))







  (let ()
    (define parser
      (lalr-parser
       `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
         (driver: glr)
         (results: all)
         (on-conflict: ,ignore)
         (rules:
          (expr     (expr add expr) : (,save $1 $2 $3)
                    (term) : (,save $1))
          (add      (+) : (,save $1))
          (term     (NUM) : (,save $1))))))

    (define result
      (lalr-parser-run
       parser
       (make-repeating-lexer
        t2-input-size
        (list (make-lexical-token 'NUM #f "5")
              (make-lexical-token '+ #f "+")))))

    (assert (procedure? result))
    (assert (result 'get)))








  (let ()
    (define parser
      (lalr-parser
       `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
         (rules:
          (expr     (expr add expr) : (,save 'expr $1 $2 $3)
                    (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
                    (term) : (,save 'expr $1))
          (add      (+) : (,save 'add $1))
          (term     (NUM) : (,save 'term $1))))))

    (define result
      (lalr-parser-run
       parser
       (make-brackets-lexer t3-input-size)))

    (assert= #t result))





  (let ()
    (define parser
      (lalr-parser
       `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
         (driver: glr)
         (results: all)
         (on-conflict: ,ignore)
         (rules:
          (expr     (expr add expr) : (,save 'expr $1 $2 $3)
                    (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
                    (term) : (,save 'expr $1))
          (add      (+) : (,save 'add $1))
          (term     (NUM) : (,save 'term $1))))))

    (define result
      (lalr-parser-run
       parser (make-brackets-lexer t4-input-size)))

    (assert (procedure? result))
    (assert (result 'get))))


(run-cases 9999 15 999 99)
