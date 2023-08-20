
(let ()
  (define failures (stack-make))

  (define (check-code name filename)
    (define expected-filename
      (stringf "test/data/~a.sld" name))

    (define generated
      (read-string-file filename))

    (define expected
      (if (file-exists? expected-filename)
          (read-string-file expected-filename)
          #f))

    (unless (equal? expected generated)
      (stack-push! failures name)))

  (define (save+check type driver code)
    (define name
      (string->symbol
       (stringf "parser-~a-~a" type driver)))
    (define filename
      (stringf "scripts/generated/~a.sld" name))

    (call-with-output-file
        filename
      (lambda (p)
        (write `(define-library (data ,name)
                  (export ,name)
                  (import (scheme base))
                  (begin (define ,name ,code)))
               p)
        (newline p)))

    (check-code name filename))

  (define (generate-repating driver)
    (lalr-parser
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (on-conflict: ,ignore)
       (output-code: ,(comp (save+check "repeating" driver)))
       (driver: ,(string->symbol driver))
       (rules:
        (expr     (expr add expr) : #t
                  (term) : #t)
        (add      (+) : #t)
        (term     (NUM) : #t)))))

  (define (generate-branching driver)
    (lalr-parser
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (driver: ,(string->symbol driver))
       (on-conflict: ,ignore)
       (output-code: ,(comp (save+check "branching" driver)))
       (rules:
        (expr     (expr add expr) : #t
                  (LPAREN expr RPAREN) : #t
                  (term) : #t)
        (add      (+) : #t)
        (term     (NUM) : #t)))))

  (define (generate driver)
    (generate-repating driver)
    (generate-branching driver))

  (for-each generate '("lr" "glr"))

  (for-each
   (lambda (failure)
     (printf "FAIL: ~s\n" failure))
   (stack->list failures))

  (assert (stack-empty? failures)))

(let ()

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

  (define (error-procedure type message-fmt token)
    (raisu* :type 'parse-error
            :message (stringf message-fmt token)
            :args (list type token)))

  (define (run-input parser input)
    (with-string-as-input
     input (parser (make-lexer) error-procedure)))

  (define (load-and-use driver)
    (define-values (parser-repeating parser-branching)
      (cond
       ((equal? driver "lr")
        (values (parser-repeating-lr (vector))
                (parser-branching-lr (vector))))
       ((equal? driver "glr")
        (values (parser-repeating-glr (vector))
                (parser-branching-glr (vector))))
       (else
        (raisu 'bad-driver-type driver))))

    (cond
     ((equal? driver "lr")
      (assert #t (run-input parser-repeating "5+5+5+5"))
      (assert #t (run-input parser-branching "5+(5+(5+5))")))
     ((equal? driver "glr")
      (assert (pair? (run-input parser-repeating "5+5+5+5")))
      (assert (pair? (run-input parser-branching "5+(5+(5+5))"))))
     (else
      (raisu 'bad-driver-type driver))))

  (for-each load-and-use '("lr" "glr")))
