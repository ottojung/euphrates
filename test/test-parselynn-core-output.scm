
(let ()
  (define current-code #f)
  (define (set-code code)
    (set! current-code code))

  (define parser
    (parselynn:core
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add term)
                  (term))
        (add      (mspace + mspace))
        (term     (mspace NUM mspace))
        (mspace   (SPACE mspace) ())))))

  (set-code
   (parselynn:core:serialize parser))

  (assert current-code)
  (assert (list? current-code))
  (assert (zoreslava? (zoreslava:deserialize current-code))))

(let ()
  (define out (open-output-string))

  (define parser
    (parselynn:core
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (output-table: ,out)
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
    (parselynn:core
     `((output-table: ,out)
       (tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add term)
                  (term))
        (add      (mspace + mspace))
        (term     (mspace NUM mspace))
        (mspace   (SPACE mspace) ())))))

  (define _1723613
    (set-code
     (parselynn:core:serialize parser)))

  (define out-table (get-output-string out))

  (assert (string? out-table))
  (assert (< 10 (string-length out-table)))
  (assert current-code)
  (assert (list? current-code))
  (assert (zoreslava? (zoreslava:deserialize current-code))))
