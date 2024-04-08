
(define (error-procedure type message-fmt token)
  (raisu* :type 'parse-error
          :message (stringf message-fmt token)
          :args (list type token)))

(define (make-test-parser parser-rules)
   (parselynn/simple
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
  (parselynn/simple:run/with-error-handler
   parser error-procedure input))

;;;;;;;;;;;;;;;;
;; TEST CASES ;;
;;;;;;;;;;;;;;;;



(parselynn/simple
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
 `( expr = expr add expr / term
    add = "+"
    term = num
    num = dig num / dig
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

 "5+3"

 '(expr (expr (term (num (dig "5")))) (add "+") (expr (term (num (dig "3"))))))





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





(parselynn/simple
 `(:grammar
   ( expr = t_term add expr / t_term
     add = "+"
     t_term = num
     num = dig num / dig
     dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")))



;; note the duplicated lexical unit "1"
(test-parser
 `( expr = term add expr / term
    add = "+" / "1"
    term = num
    num = dig+
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

 "72+8"
 '(expr (term (num (dig+ (dig "7") (dig+ (dig "2"))))) (add "+") (expr (term (num (dig+ (dig "8")))))))




;;;;;;;
;;
;; Multicharacter string usage
;;

;; FIXME: finish these cases.
;; TODO: finish these cases.


;; (test-parser
;;  `( expr = choice+
;;     choice = "aaa" / "bbb" )

;;  "aaa"
;;  '(expr (choice+ (choice "aaa"))))

;; ;; '(expr
;; ;;   (choice+
;; ;;    (choice "a")
;; ;;    (choice+
;; ;;     (choice "a")
;; ;;     (choice+
;; ;;      (choice "a"))))))




;; (test-parser
;;  `( expr = choice+
;;     choice = "aaa" / "bbb" )

;;  "aaabbbaaabbb"
;;  '(expr (choice+
;;          (choice "aaa")
;;          (choice+
;;           (choice "bbb")
;;           (choice+
;;            (choice "aaa")
;;            (choice+
;;             (choice "bbb")))))))




;; (test-parser
;;  `( expr = choice+
;;     choice = "aaa" / "bbb" )

;;  "aaabbbaaaaaa"
;;  '(expr (choice+
;;          (choice "aaa")
;;          (choice+
;;           (choice "bbb")
;;           (choice+
;;            (choice "aaa")
;;            (choice+ (choice "aaa")))))))




;; (test-parser
;;  `( expr = choice+
;;     choice = "aaa" / "b" )

;;  "aaabbbaaabbaaa"
;;  '(expr (choice+
;;          (choice "aaa")
;;          (choice+
;;           (choice "b")
;;           (choice+
;;            (choice "b")
;;            (choice+
;;             (choice "b")
;;             (choice+
;;              (choice "aaa")
;;              (choice+
;;               (choice "b")
;;               (choice+
;;                (choice "b")
;;                (choice+
;;                 (choice "aaa")))))))))))



;; (test-parser
;;  `( expr = term add expr / term
;;     add = "+"
;;     term = num / "!"
;;     num = dig+
;;     dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

;;  "42+8+!"

;;  '(expr (term (num (dig+ (dig "4") (dig+ (dig "2"))))) (add "+") (expr (term (num (dig+ (dig "8")))) (add "+") (expr (term "!")))))



;; (test-parser
;;  `( expr = term add expr / term
;;     add = "+"
;;     term = num / "!42"
;;     num = dig+
;;     dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

;;  "42+8+!42"

;;  '(expr (term (num (dig+ (dig "4")
;;                          (dig+ (dig "2")))))
;;         (add "+")
;;         (expr
;;          (term (num (dig+ (dig "8"))))
;;          (add "+")
;;          (expr (term "!42")))))



;; (assert-throw
;;  'parse-conflict

;;  (parselynn/simple
;;   `(:grammar

;;     ( expr = term add expr / term
;;       add = "+"
;;       term = num / "42"
;;       num = dig+
;;       dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"))))

;;;;;;;;;;;;;
;;
;; Single set cases
;;


(check-parser-result-and-reverse
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :join (dig)))

 "5+3"
 '(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3"))))))





(check-parser-result-and-reverse
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = num1
      num1 = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :join (num1)))

 "72+8"
 '(expr (term (num (num1 "72"))) (add "+") (expr (term (num (num1 "8"))))))




(check-parser-result-and-reverse
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :join (expr)))

 "5+3"
 '(expr "5+3"))






(check-parser-result-and-reverse
 (parselynn/simple
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
 '(expr (term (num (dig "3") (num (dig "5")))) (add "+") (expr (term (id (id1 "x7"))))))






(check-parser-result-and-reverse
 (parselynn/simple
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
 '(expr (term (num (num1 "35"))) (add "+") (expr (term (id (id1 "x7"))))))





(assert-throw
 'invalid-set
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :join num)))





(assert-throw
 'invalid-set
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :skip (whatever))))






(check-parser-result
 (parselynn/simple
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
 (parselynn/simple
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
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :flatten ()))

 "5+3"
 '(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3"))))))





(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :flatten (expr)))

 "5+3"
 '(expr (term (num (dig "5"))) (add "+") (term (num (dig "3")))))





(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (dig num)))

 "5+3"
 '(expr (term "5") (add "+") (expr (term "3"))))



(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (term)))

 "5+3"
 '(expr (num (dig "5")) (add "+") (expr (num (dig "3")))))




(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (num dig)))

 "54+3"
 '(expr (term "5" "4") (add "+") (expr (term "3"))))




;;;;;;;;;;;;;
;;
;; Multiple set cases
;;

(check-parser-result
 (parselynn/simple
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
 (parselynn/simple
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
 'invalid-set
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :flatten num)))



(check-parser-result
 (parselynn/simple
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
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :join (term add)))

 "  83712    + 371673    "
 '(expr (term "  83712    ") (add "+") (expr (term " 371673    "))))




(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (term add)
    :join (term add)))

 "  83712    + 371673    "
 '(expr "  83712    " "+" (expr " 371673    ")))





(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = num1
      num1 = dig num1 / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (term num1)
    :flatten (term)
    :join (num1)
    :skip (space)))

 "  83712    + 371673    "
 '(expr (num "83712") (add "+") (expr (num "371673"))))





(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = num1
      num1 = dig num1 / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (term add)
    :join (term add)
    :skip (space)))

 "  83712    + 371673    "
 '(expr "83712" "+" (expr "371673")))






(check-parser-result
 (parselynn/simple
  `(:grammar
    ( root = expr
      expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = num1
      num1 = dig num1 / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (expr)
    :join (expr)
    :skip (space)))

 "  83712    + 371673    "
 '(root "83712+371673"))




(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = num1
      num1 = dig num1 / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (term add)
    :join (term add)
    :flatten (expr)
    :skip (space)))

 "  83712    + 371673    "
 '(expr "83712" "+" "371673"))




(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = num1
      num1 = dig num1 / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (num)
    :join (num)
    :flatten (term)
    :skip (space)))

 "  83712    + 371673    "
 '(expr (term "83712") (add "+") (expr (term "371673"))))






(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig+
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (num)
    :join (num)
    :flatten (term)
    :skip (space)))

 "  83712    + 371673    "
 '(expr (term "83712") (add "+") (expr (term "371673"))))





(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig+
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (expr num)
    :join (num)
    :flatten (term)
    :skip (space)))

 "  83712    + 371673    "
 '(expr (term "83712") (add "+") (term "371673")))


;;;;;;
;;
;; Character classes
;;


(test-parser
 `( expr = term add expr / term
    add = "+"
    term = num
    num = dig+
    dig = (class numeric))

 "3+8"
 '(expr (term (num (dig+ (dig "3"))))
        (add "+")
        (expr (term (num (dig+ (dig "8")))))))



(test-parser
 `( expr = term add expr / term
    add = "+" / "1"
    term = num
    num = dig+
    dig = (class numeric))

 "3+8"
 '(expr (term (num (dig+ (dig "3"))))
        (add "+")
        (expr (term (num (dig+ (dig "8")))))))




(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig+
      dig = (class numeric)
      space = (class whitespace))

    :inline (num)
    :join (num)
    :flatten (term)
    :skip (space)))

 "  83712    + 371673    "
 '(expr (term "83712") (add "+") (expr (term "371673"))))


(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig+
      dig = (class numeric)
      space = (class whitespace))

    :inline (add num)
    :join (num)
    :flatten (term)
    :skip (space)))

 "  83712    + 371673    "
 '(expr (term "83712") "+" (expr (term "371673"))))





(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig+
      dig = (class numeric) / (class alphabetic)
      space = (class whitespace))

    :inline (add num)
    :join (num)
    :flatten (term)
    :skip (space)))

 "  83712b2    + 0x371673    "
 '(expr (term "83712b2") "+" (expr (term "0x371673"))))




(assert-throw
 'parse-conflict

 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig+
      dig = (class numeric) / (class alphabetic) / (class alphanum)
      space = (class whitespace))

    :inline (add num)
    :join (num)
    :flatten (term)
    :skip (space))))





(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig+
      dig = (class alphanum)
      space = (class whitespace))

    :inline (add num)
    :join (num)
    :flatten (term)
    :skip (space)))

 "  83712b2    + 0x371673    "
 '(expr (term "83712b2") "+" (expr (term "0x371673"))))




(assert-throw
 'parse-conflict

 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig+
      dig = (class numeric) / (class numeric)
      space = (class whitespace))

    :inline (num)
    :join (num)
    :flatten (term)
    :skip (space))))





(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig+
      dig = (class numeric)
      dig/unused = (class numeric)
      space = (class whitespace))

    :inline (num)
    :join (num)
    :flatten (term)
    :skip (space)))

 "  83712    + 371673    "
 '(expr (term "83712") (add "+") (expr (term "371673"))))




;;;;;;;;;;;;;;;;;;;
;;
;; Final pretty examples
;;




(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig+
      dig = (class numeric)
      space = (class whitespace))

    :inline (term)
    :join (num)
    :flatten (term expr)
    :skip (space)))

 "  83712    + 371673    "
 '(expr (num "83712") (add "+") (num "371673")))




(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = term add expr / term
      add = "+" / space add / add space
      term = num / space term / term space
      num = dig+
      dig = (class numeric)
      space = (class whitespace))

    :inline (num term add)
    :join (num)
    :flatten (term expr)
    :skip (space)))

 "  83712    + 371673    "
 '(expr "83712" "+" "371673"))





(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = expr add expr / term
      add = (class (or (= #\+) (= #\-) (= #\*) (= #\/)))
      term = id / num
      id = idstart idcont / idstart
      idstart = (class alphabetic)
      idcont = idchar idcont / idchar
      idchar = (class (and alphanum (not (= #\0))))
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :inline (num id term add)
    :join (num id)
    :flatten (term expr)
    ;; :skip (space)

    ))

 "42+x-y*42+x-y*42+x-y*42+x-y*42+x-y*42+x-y"
 '(expr "42" "+" "x" "-" "y" "*" "42" "+" "x" "-" "y" "*" "42" "+" "x" "-" "y" "*" "42" "+" "x" "-" "y" "*" "42" "+" "x" "-" "y" "*" "42" "+" "x" "-" "y"))




(check-parser-result
 (parselynn/simple
  `(:grammar
    ( expr = expr add expr / term / space expr / expr space
      add = (class (or (= #\+) (= #\-) (= #\*) (= #\/)))
      term = id / num
      id = idstart idcont / idstart
      idstart = (class alphabetic)
      idcont = idchar idcont / idchar
      idchar = (class (and alphanum (not (= #\0))))
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = (class whitespace)
      )

    :inline (num id term add)
    :join (num id)
    :flatten (term expr)
    :skip (space)

    ))

 " 42 + x2 -     y* 59 + x  "
 '(expr "42" "+" "x2" "-" "y" "*" "59" "+" "x"))
