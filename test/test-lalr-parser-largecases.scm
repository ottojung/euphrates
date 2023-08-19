
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

(define save (const #t))

;;;;;;;;;;;;
;;
;; Sanity check
;;



(let ()
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
    (with-string-as-input
     "5+3" (parser (make-lexer) error-procedure)))

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
     "5++" (parser (make-lexer) error-procedure)))

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

  (define (error-procedure type message-fmt token)
    (raisu* :type 'parse-error
            :message (stringf message-fmt token)
            :args (list type token)))

  (define result
    (parser (make-repeating-lexer
             3
             (list (make-lexical-token 'NUM #f "5")
                   (make-lexical-token '+ #f "+")
                   (make-lexical-token 'NUM #f "3")))
             error-procedure))

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

  (define (error-procedure type message-fmt token)
    (raisu* :type 'parse-error
            :message (stringf message-fmt token)
            :args (list type token)))

  (define result
    (parser (make-repeating-lexer
             9
             (list (make-lexical-token 'NUM #f "5")
                   (make-lexical-token '+ #f "+")))
             error-procedure))

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
    (parser (make-repeating-lexer
             3
             (list (make-lexical-token 'NUM #f "5")
                   (make-lexical-token '+ #f "+")
                   (make-lexical-token '+ #f "+")))
             error-procedure))

  (assert= #f result))




(let ()
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
             5
             (list (make-lexical-token 'NUM #f "5")
                   (make-lexical-token '+ #f "+")))
             error-procedure))

  (assert (list? result))
  (assert (not (null? result))))



;;;;;;;;;;;;;;;;;;
;;
;; Actual large tests
;;



(let ()
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
             99999
             (list (make-lexical-token 'NUM #f "5")
                   (make-lexical-token '+ #f "+")))
             error-procedure))

  (assert= #t result))







(let ()
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
             15
             (list (make-lexical-token 'NUM #f "5")
                   (make-lexical-token '+ #f "+")))
             error-procedure))

  (assert (list? result))
  (assert (not (null? result))))
