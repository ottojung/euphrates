
(define (collect-iterator iter)
  (let loop ((buf '()))
    (define x (iter))
    (if x
        (loop (cons x buf))
        buf)))

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

  (define (run-input parser input)
    (with-string-as-input
     input
     (let ((result (parselynn-run parser (make-lexer))))
       (if (procedure? result)
           (collect-iterator result)
           result))))

  (define (load-and-use driver)
    (define-values (parser-repeating parser-branching)
      (cond
       ((equal? driver "lr")
        (values (parselynn-load parser-repeating-lr)
                (parselynn-load parser-branching-lr)))
       ((equal? driver "glr")
        (values (parselynn-load parser-repeating-glr)
                (parselynn-load parser-branching-glr)))
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
