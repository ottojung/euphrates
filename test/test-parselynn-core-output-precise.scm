
(let ()
  (define failures (stack-make))

  (define (check-code name filename)
    (define expected-filename
      (stringf "test/data/~a.sld" name))

    (define generated
      (call-with-input-file filename read-list))

    (define expected
      (if (file-exists? expected-filename)
          (call-with-input-file expected-filename read-list)
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
    (define parser
      (parameterize ((parselynn:core:conflict-handler/p ignore))
        (parselynn:core
         `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
           (driver: ,(string->symbol driver))
           (results: ,(if (equal? (~a driver) "glr") 'all 'first))
           (rules:
            (expr     (expr add expr) : #t
                      (term) : #t)
            (add      (+) : #t)
            (term     (NUM) : #t))))))

    (save+check
     "repeating" driver
     (parselynn:core:serialize parser)))

  (define (generate-branching driver)
    (define parser
      (parameterize ((parselynn:core:conflict-handler/p ignore))
        (parselynn:core
         `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
           (driver: ,(string->symbol driver))
           (results: ,(if (equal? (~a driver) "glr") 'all 'first))
           (rules:
            (expr     (expr add expr) : #t
                      (LPAREN expr RPAREN) : #t
                      (term) : #t)
            (add      (+) : #t)
            (term     (NUM) : #t))))))

    (save+check
     "branching" driver
     (parselynn:core:serialize parser)))

  (define (generate driver)
    (generate-repating driver)
    (generate-branching driver))

  (for-each generate '("lr" "glr"))

  (for-each
   (lambda (failure)
     (printf "FAIL: ~s\n" failure))
   (stack->list failures))

  (assert (stack-empty? failures)))
