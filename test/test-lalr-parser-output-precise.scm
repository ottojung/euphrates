
(let ()
  (define (save-code type driver code)
    (define name
      (string->symbol
       (stringf "data-parser-~a-~a" type driver)))
    (call-with-output-file
        (stringf "test/generated/~a.sld" name)
      (lambda (p)
        (write `(define-library (,name)
                  (export ,name)
                  (import (scheme base))
                  (begin ,@code))
               p)
        (newline p))))

  (define (generate-repating driver)
    (lalr-parser
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (on-conflict: ,ignore)
       (output-code: ,(comp (save-code "repeating" driver)))
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
       (output-code: ,(comp (save-code "branching" driver)))
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

  (define generated-repeating-lr
    (read-string-file "test/generated/data-parser-repeating-lr.sld"))

  (define current-repeating-lr
    (read-string-file "test/data-parser-repeating-lr.sld"))

  (assert= current-repeating-lr generated-repeating-lr)


  0)
