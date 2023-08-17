
(let ()
  (define current-code #f)
  (define (set-code code)
    (set! current-code code))

  (define parser
    (lalr-parser
     `((output-code: ,set-code)
       (tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add term)
                  (term))
        (add      (mspace + mspace))
        (term     (mspace NUM mspace))
        (mspace   (SPACE mspace) ())))))

  (assert current-code)
  (assert (list? current-code))
  (assert (list-length=<? 10 current-code)))
