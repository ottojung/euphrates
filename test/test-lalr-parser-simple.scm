
(define (error-procedure type message-fmt token)
  (raisu* :type 'parse-error
          :message (stringf message-fmt token)
          :args (list type token)))

(define (make-test-parser parser-rules)
   (lalr-parser/simple
    `(:grammar ,parser-rules)))

(define-syntax check-parser-result
  (syntax-rules ()
    ((_ parser input expected-output)
     (let ()
       (define result
         (run-input parser input))

       (assert= result expected-output)
       result))))

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
  (parser error-procedure input))

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

    :join (dig)))

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

    :join (num1)))

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

    :join (expr)))

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

    :join (id1)))

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

    :join (id1 num1)))

 "35+x7"
 '(expr (term (num "35")) (add "+") (expr (term (id "x7")))))





(assert-throw
 'invalid-join-set
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :join num)))





(assert-throw
 'invalid-set
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :skip (whatever))))






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

    :flatten (term)
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

    :flatten (term)
    :skip (space)))

 "  5    + 3    "
 '(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3"))))))





(assert-throw
 'invalid-flatten-set
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

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

    :flatten (num term)
    :skip (space)))

 "  83712    + 371673    "

 '(expr (term (num (dig "8") (dig "3") (dig "7") (dig "1") (dig "2"))) (add "+") (expr (term (num (dig "3") (dig "7") (dig "1") (dig "6") (dig "7") (dig "3"))))))





(check-parser-result
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :join (term add)))

 "  83712    + 371673    "
 '(expr "  83712    " "+" (expr " 371673    ")))





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

    :flatten (term)
    :join (num1)
    :skip (space)))

 "  83712    + 371673    "
 '(expr (term (num "83712")) (add "+") (expr (term (num "371673")))))





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

    :join (term add)
    :skip (space)))

 "  83712    + 371673    "
 '(expr "83712" "+" (expr "371673")))






(check-parser-result
 (lalr-parser/simple
  `(:grammar
    ( root = expr
      expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = num1
      num1 = dig num1 / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :join (expr)
    :skip (space)))

 "  83712    + 371673    "
 '(root "83712+371673"))




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

    :join (term add)
    :flatten (expr)
    :skip (space)))

 "  83712    + 371673    "
 '(expr "83712" "+" "371673"))




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

    :join (num)
    :flatten (term)
    :skip (space)))

 "  83712    + 371673    "
 '(expr (term "83712") (add "+") (expr (term "371673"))))






(check-parser-result
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig+
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :join (num)
    :flatten (term)
    :skip (space)))

 "  83712    + 371673    "
 '(expr (term "83712") (add "+") (expr (term "371673"))))





(check-parser-result
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig+
      dig = (re (or "0" "1" "2" "3" "4" "5" "6" "7" "8" "9"))
      space = " ")

    :join (num)
    :flatten (term)
    :skip (space)))

 "  83712    + 371673    "
 '(expr (term "83712") (add "+") (expr (term "371673"))))





(check-parser-result
 (lalr-parser/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig+
      dig = (re numeric)
      space = (re whitespace))

    :join (num)
    :flatten (term)
    :skip (space)))

 "  83712    + 371673    "
 '(expr (term "83712") (add "+") (expr (term "371673"))))


(let ()

  (define tag-grammar
    `( tag = word arg*
       arg = eqq idset
       idset = variable comma idset / variable
       word = (re alpha (* alphanum))
       variable = word
       comma = "," / "+"
       eqq = "="
       ))

  (define backend-parser
    (lalr-parser/simple
     `(:grammar ,tag-grammar
       :flatten (arg*))))

  0)
