
(define (error-procedure type message-fmt token)
  (raisu* :type 'parse-error
          :message (stringf message-fmt token)
          :args (list type token)))

(define (make-test-parser parser-rules)
   (lalr-parser/simple
    `(:grammar ,parser-rules
      :spineless? no)))

(define (check-parser-result parser input expected-output)
  (define result
    (run-input parser input))

  (assert= result expected-output)
  result)

(define (check-parser-result-and-reverse parser input expected-output)
  (define result (check-parser-result parser input expected-output))

  (define reversed
    (if (list? result)
        (apply string-append
               (filter string? (list-collapse result)))
        result))

  (assert= input reversed))

(define (test-parser parser-rules input expected-output)
  (define parser
    (make-test-parser parser-rules))

  (check-parser-result-and-reverse parser input expected-output))

(define (test-parser-error parser-rules input)
  (define parser
    (make-test-parser parser-rules))

  (assert-throw
   'parse-error
   (run-input parser input)))

(define (run-input parser input)
  (with-string-as-input
   input (parser error-procedure)))

;;;;;;;;;;;;;;;;
;; TEST CASES ;;
;;;;;;;;;;;;;;;;



(lalr-parser/simple
 `(:grammar
   ( expr = term add expr / term
     add = "+"
     term = num
     num = dig num / dig
     dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")))




(test-parser
 `( expr = term add expr / term
    add = "+"
    term = num
    num = dig num / dig
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

 "5+3"
 '(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3"))))))





(test-parser
 `( expr = term add expr / term
    add = "+" / space add / add space
    term = num / space term / term space
    num = dig num / dig
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
    space = " ")

 " 5 + 3 "
 '(expr (term (space " ") (term (term (num (dig "5"))) (space " "))) (add "+") (expr (term (space " ") (term (term (num (dig "3"))) (space " "))))))




(test-parser
 `( expr = term add expr / term
    add = "+"
    term = num
    num = dig+
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

 "72+8"
 '(expr (term (num (dig+ (dig "7") (dig+ (dig "2"))))) (add "+") (expr (term (num (dig+ (dig "8")))))))





(lalr-parser/simple
 `(:grammar
   ( expr = t_term add expr / t_term
     add = "+"
     t_term = num
     num = dig num / dig
     dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")))



(check-parser-result-and-reverse
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :spineless? no
    :flatten (dig)))

 "5+3"
 '(expr (term (num "5")) (add "+") (expr (term (num "3")))))





(check-parser-result-and-reverse
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = num1
      num1 = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :spineless? no
    :flatten (num1)))

 "72+8"
 '(expr (term (num "72")) (add "+") (expr (term (num "8")))))




(check-parser-result-and-reverse
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :spineless? no
    :flatten (expr)))

 "5+3"
 "5+3")






(check-parser-result-and-reverse
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+"
      term = num / id
      num = dig num / dig
      id = id1
      id1 = "x" / "y" / id1 dig / id1 id1
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :spineless? no
    :flatten (id1)))

 "35+x7"
 '(expr (term (num (dig "3") (num (dig "5")))) (add "+") (expr (term (id "x7")))))






(check-parser-result-and-reverse
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+"
      term = num / id
      num = num1
      num1 = dig num / dig
      id = id1
      id1 = "x" / "y" / id1 dig / id1 id1
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :spineless? no
    :flatten (id1 num1)))

 "35+x7"
 '(expr (term (num "35")) (add "+") (expr (term (id "x7")))))





(assert-throw
 'invalid-flatten-set
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :flatten num)))





(check-parser-result
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :spineless? no
    :skip (space)))

 " 5 + 3 "
 '(expr (term (term (term (num (dig "5"))))) (add "+") (expr (term (term (term (num (dig "3"))))))))




(check-parser-result
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :spineless? no
    :skip (space)))

 "  5    + 3    "
 '(expr (term (term (term (term (term (term (term (num (dig "5"))))))))) (add "+") (expr (term (term (term (term (term (term (num (dig "3")))))))))))







(check-parser-result
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :spineless? yes
    :skip (space)))

 "  5    + 3    "
 '(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3"))))))






(check-parser-result
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :skip (space)))

 "  5    + 3    "
 '(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3"))))))





(assert-throw
 'invalid-spineless-option
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :spineless? whatever)))





(check-parser-result
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = num1
      num1 = dig num1 / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :flatten (num1)
    :skip (space)))

 "  83712    + 371673    "
 '(expr (term (num "83712")) (add "+") (expr (term (num "371673")))))

