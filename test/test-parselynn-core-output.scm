
(define (get-diff struct1 struct2)

  ;; (define diff
  ;;   (parselynn:core:diff struct1 struct2))

  ;; (define diff*
  ;;   (filter
  ;;    (negate
  ;;     (lambda (p) (equal? (car p) 'maybefun)))
  ;;    diff))

  (define diff
    (map car
         (parselynn:core:diff struct1 struct2)))

  (define diff*
    (delete 'maybefun diff))

  diff*)

(define (test-serialization parser)
  (define deserialized
    (parselynn:core:deserialize
     (parselynn:core:serialize parser)))

  (define diff
    (get-diff parser deserialized))

  (assert= '() diff))


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
  (test-serialization parser)
  (assert (zoreslava? (zoreslava:deserialize current-code))))

(let ()
  (define out (open-output-string))

  (define parser
    (parameterize ((parselynn:core:output-table-port/p out))
      (parselynn:core
       `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
         (rules:
          (expr     (expr add term)
                    (term))
          (add      (mspace + mspace))
          (term     (mspace NUM mspace))
          (mspace   (SPACE mspace) ()))))))

  (define out-table (get-output-string out))

  (assert (string? out-table))
  (test-serialization parser)
  (assert (< 10 (string-length out-table))))

(let ()
  (define out (open-output-string))
  (define current-code #f)
  (define (set-code code)
    (set! current-code code))

  (define parser
    (parameterize ((parselynn:core:output-table-port/p out))
      (parselynn:core
       `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
         (rules:
          (expr     (expr add term)
                    (term))
          (add      (mspace + mspace))
          (term     (mspace NUM mspace))
          (mspace   (SPACE mspace) ()))))))

  (define _1723613
    (set-code
     (parselynn:core:serialize parser)))

  (define out-table (get-output-string out))

  (assert (string? out-table))
  (assert (< 10 (string-length out-table)))
  (assert current-code)
  (assert (list? current-code))
  (test-serialization parser)
  (assert (zoreslava? (zoreslava:deserialize current-code))))
