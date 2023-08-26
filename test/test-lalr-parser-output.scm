
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
  (assert (list-length=<? 5 current-code)))

(let ()
  (define out (open-output-string))

  (define parser
    (lalr-parser
     `((output-table: ,out)
       (tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add term)
                  (term))
        (add      (mspace + mspace))
        (term     (mspace NUM mspace))
        (mspace   (SPACE mspace) ())))))

  (define out-table (get-output-string out))

  (assert (string? out-table))
  (assert (< 10 (string-length out-table))))

(let ()
  (define out (open-output-string))
  (define current-code #f)
  (define (set-code code)
    (set! current-code code))

  (define parser
    (lalr-parser
     `((output-table: ,out)
       (output-code: ,set-code)
       (tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add term)
                  (term))
        (add      (mspace + mspace))
        (term     (mspace NUM mspace))
        (mspace   (SPACE mspace) ())))))

  (define out-table (get-output-string out))

  (assert (string? out-table))
  (assert (< 10 (string-length out-table)))
  (assert current-code)
  (assert (list? current-code))
  (assert (list-length=<? 5 current-code)))
