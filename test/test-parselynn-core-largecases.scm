
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
                ((char=? c #\newline) (parselynn:token:make 'NEWLINE location 'NEWLINE))
                ((char-whitespace? c) (parselynn:token:make 'SPACE   location 'SPACE))
                ((char=? c #\+)       (parselynn:token:make '+       location (string c)))
                ((char=? c #\-)       (parselynn:token:make '-       location (string c)))
                ((char=? c #\*)       (parselynn:token:make '*       location (string c)))
                ((char=? c #\/)       (parselynn:token:make '/       location (string c)))
                ((char=? c #\=)       (parselynn:token:make '=       location (string c)))
                ((char=? c #\,)       (parselynn:token:make 'COMMA   location (string c)))
                ((char=? c #\()       (parselynn:token:make 'LPAREN  location (string c)))
                ((char=? c #\))       (parselynn:token:make 'RPAREN  location (string c)))
                ((char-numeric? c)    (parselynn:token:make 'NUM     location (read-number (list c))))
                ((char-alphabetic? c) (parselynn:token:make 'ID      location (read-id (list c))))
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
      (parselynn:token:make t #f v))
     ((> maxdepth how-deep)
      (if (< (+ 1 closecount) maxdepth)
          (begin
            (set! closecount (+ closecount 1))
            (parselynn:token:make 'RPAREN #f ")"))
          '*eoi*))
     (else
      (if (equal? t 'LPAREN)
          (begin
            (set! maxdepth (+ maxdepth 1))
            (parselynn:token:make 'NUM #f "1"))
          (parselynn:token:make t #f v)))))

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
              (display (parselynn:token:value t))
              (loop)))))

(let ()
  (define parser
    (parselynn:core
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add expr) : (,save $1 $2 $3)
                  (term) : (,save $1))
        (add      (+) : (,save $1))
        (term     (NUM) : (,save $1))))))

  (define result
    (with-string-as-input
     "5+3" (parselynn-run parser (make-lexer))))

  (assert= #t result))





(let ()
  (define parser
    (parselynn:core
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add expr) : (,save $1 $2 $3)
                  (term) : (,save $1))
        (add      (+) : (,save $1))
        (term     (NUM) : (,save $1))))))

  (define error-procedure ignore)

  (define result
    (with-string-as-input
     "5++" (parselynn-run/with-error-handler
            parser error-procedure (make-lexer))))

  (assert= #f result))




(let ()
  (define parser
    (parselynn:core
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add expr) : (,save $1 $2 $3)
                  (term) : (,save $1))
        (add      (+) : (,save $1))
        (term     (NUM) : (,save $1))))))

  (define result
    (parselynn-run
     parser
     (make-repeating-lexer
      3 (list (parselynn:token:make 'NUM #f "5")
              (parselynn:token:make '+ #f "+")
              (parselynn:token:make 'NUM #f "3")))))

  (assert= #t result))




(let ()
  (define parser
    (parselynn:core
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add expr) : (,save $1 $2 $3)
                  (term) : (,save $1))
        (add      (+) : (,save $1))
        (term     (NUM) : (,save $1))))))

  (define result
    (parselynn-run
     parser
     (make-repeating-lexer
      9 (list (parselynn:token:make 'NUM #f "5")
              (parselynn:token:make '+ #f "+")))))

  (assert= #t result))




(let ()
  (define parser
    (parselynn:core
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add expr) : (,save $1 $2 $3)
                  (term) : (,save $1))
        (add      (+) : (,save $1))
        (term     (NUM) : (,save $1))))))

  (define error-procedure ignore)

  (define result
    (parselynn-run/with-error-handler
     parser
     error-procedure
     (make-repeating-lexer
      3 (list (parselynn:token:make 'NUM #f "5")
              (parselynn:token:make '+ #f "+")
              (parselynn:token:make '+ #f "+")))))

  (assert= #f result))




(let ()
  (define parser
    (parameterize ((parselynn:core:conflict-handler/p ignore))
      (parselynn:core
       `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
         (driver: glr)
         (results: all)
         (rules:
          (expr     (expr add expr) : (,save $1 $2 $3)
                    (term) : (,save $1))
          (add      (+) : (,save $1))
          (term     (NUM) : (,save $1)))))))

  (define result
    (parselynn-run
     parser
     (make-repeating-lexer
      5 (list (parselynn:token:make 'NUM #f "5")
              (parselynn:token:make '+ #f "+")))))

  (assert (procedure? result))
  (assert (result 'get)))




(let ()
  (define parser
    (parselynn:core
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add expr) : (,save 'expr $1 $2 $3)
                  (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
                  (term) : (,save 'expr $1))
        (add      (+) : (,save 'add $1))
        (term     (NUM) : (,save 'term $1))))))

  (define result
    (parselynn-run
     parser (make-brackets-lexer 3)))

  (assert= #t result))





(let ()
  (define parser
    (parameterize ((parselynn:core:conflict-handler/p ignore))
      (parselynn:core
       `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
         (driver: glr)
         (results: all)
         (rules:
          (expr     (expr add expr) : (,save 'expr $1 $2 $3)
                    (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
                    (term) : (,save 'expr $1))
          (add      (+) : (,save 'add $1))
          (term     (NUM) : (,save 'term $1)))))))

  (define result
    (parselynn-run
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
      (parselynn:core
       `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
         (rules:
          (expr     (expr add expr) : (,save $1 $2 $3)
                    (term) : (,save $1))
          (add      (+) : (,save $1))
          (term     (NUM) : (,save $1))))))

    (define result
      (parselynn-run
       parser
       (make-repeating-lexer
        t1-input-size
        (list (parselynn:token:make 'NUM #f "5")
              (parselynn:token:make '+ #f "+")))))

    (assert= #t result))







  (let ()
    (define parser
      (parameterize ((parselynn:core:conflict-handler/p ignore))
        (parselynn:core
         `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
           (driver: glr)
           (results: all)
           (rules:
            (expr     (expr add expr) : (,save $1 $2 $3)
                      (term) : (,save $1))
            (add      (+) : (,save $1))
            (term     (NUM) : (,save $1)))))))

    (define result
      (parselynn-run
       parser
       (make-repeating-lexer
        t2-input-size
        (list (parselynn:token:make 'NUM #f "5")
              (parselynn:token:make '+ #f "+")))))

    (assert (procedure? result))
    (assert (result 'get)))








  (let ()
    (define parser
      (parselynn:core
       `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
         (rules:
          (expr     (expr add expr) : (,save 'expr $1 $2 $3)
                    (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
                    (term) : (,save 'expr $1))
          (add      (+) : (,save 'add $1))
          (term     (NUM) : (,save 'term $1))))))

    (define result
      (parselynn-run
       parser
       (make-brackets-lexer t3-input-size)))

    (assert= #t result))





  (let ()
    (define parser
      (parameterize ((parselynn:core:conflict-handler/p ignore))
        (parselynn:core
         `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
           (driver: glr)
           (results: all)
           (rules:
            (expr     (expr add expr) : (,save 'expr $1 $2 $3)
                      (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
                      (term) : (,save 'expr $1))
            (add      (+) : (,save 'add $1))
            (term     (NUM) : (,save 'term $1)))))))

    (define result
      (parselynn-run
       parser (make-brackets-lexer t4-input-size)))

    (assert (procedure? result))
    (assert (result 'get))))


(run-cases 9999 15 999 99)
