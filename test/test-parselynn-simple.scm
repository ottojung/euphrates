
(define (error-procedure type message-fmt token)
  (raisu* :type 'parse-error
          :message (stringf message-fmt token)
          :args (list type token)))

(define (make-test-parser parser-rules)
  (parselynn:simple
   `(:grammar ,parser-rules
     :driver (LR 1))))

(define (input-stream lst)
  (lambda _
    (if (null? lst) (eof-object)
        (let ()
          (define current (car lst))
          (set! lst (cdr lst))
          current))))

(define-syntax check-parser-result
  (syntax-rules ()
    ((_ parser input expected-output)
     (let ()
       (define result
         (run-input parser input))

       (check-parser-serialization parser)

       (unless (equal? result expected-output)
         (debug "actual:\n~s\n\n" result)
         (exit 1))

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

(define (get-diff struct1 struct2)

  ;; (define diff
  ;;   (parselynn:simple:diff struct1 struct2))

  ;; (define diff/2
  ;;   (filter
  ;;    (negate
  ;;     (lambda (p) (member (car p) '(maybefun transformations))))
  ;;    diff))

  ;; (define diff*
  ;;   (let loop ((obj diff/2))
  ;;     (cond
  ;;      ((pair? obj)
  ;;       (cons (loop (car obj))
  ;;             (loop (cdr obj))))

  ;;      ((hashset? obj)
  ;;       (map loop (hashset->list obj)))

  ;;      (else obj))))

  (define diff
    (map car
         (parselynn:simple:diff struct1 struct2)))

  (define diff*
    (delete 'transformations
            (delete 'maybefun diff)))

  diff*)

(define (check-parser-serialization parser)
  (define serialized (parselynn:simple:serialize parser))
  (define deserialized (parselynn:simple:deserialize serialized))
  (assert= '() (get-diff parser deserialized))
  (assert (not (equal? parser serialized))))

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
  (parselynn:simple:run/with-error-handler
   parser error-procedure input))

;;;;;;;;;;;;;;;;
;; TEST CASES ;;
;;;;;;;;;;;;;;;;



(parselynn:simple
 `(:grammar
   ( expr = term add expr / term
     add = "+"
     term = num
     num = dig num / dig
     dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")))




(test-parser
 `( expr = "a" / "b" )

 "a"
 '(expr "a"))





(test-parser
 `( expr = "a" / "b" expr)

 "a"
 '(expr "a"))





(test-parser
 `( expr = "a" / "b" expr)

 "bbbbbba"
 '(expr "b" (expr "b" (expr "b" (expr "b" (expr "b" (expr "b" (expr "a"))))))))






(test-parser
 `( expr = term add expr / term
    add = "+"
    term = num
    num = dig num / dig
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

 "5+3"
 '(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3"))))))






(assert-throw
 'parse-conflict
 (test-parser
  `( expr = expr add expr / term
     add = "+"
     term = num
     num = dig num / dig
     dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

  "5+3"

  '(expr (expr (term (num (dig "5")))) (add "+") (expr (term (num (dig "3")))))))





(test-parser
 `( expr = term add expr / term
    add = "+"
    term = num / space num / num space
    num = dig num / dig
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
    space = " ")

 "5+3"
 `(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3"))))))




(test-parser
 `( expr = term add expr / term
    add = "+"
    term = num / space num / num space
    num = dig num / dig
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
    space = " ")

 "5+3 "
 `(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3")) (space " ")))))




(test-parser
 `( expr = term add expr / term
    add = "+"
    term = num / sspace num / num sspace / sspace num sspace
    num = dig num / dig
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
    sspace = space / space sspace
    space = " ")

 "5+3 "
 `(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3")) (sspace (space " "))))))




(test-parser
 `( expr = term add expr / term
    add = "+"
    term = num / space num / num space
    num = dig num / dig
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
    space = " ")

 "5 + 3"
 `(expr (term (num (dig "5")) (space " ")) (add "+") (expr (term (space " ") (num (dig "3"))))))




(test-parser
 `( expr = term add expr / term
    add = "+"
    term = num
    num = dig+
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

 "72+8"
 '(expr (term (num (dig+ (dig "7") (dig+ (dig "2"))))) (add "+") (expr (term (num (dig+ (dig "8")))))))





(parselynn:simple
 `(:grammar
   ( expr = t_term add expr / t_term
     add = "+"
     t_term = num
     num = dig num / dig
     dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")))



;; note the duplicated lexical unit "1"
(test-parser
 `( expr = term " " add " " expr / term
    add = "+" / "1"
    term = num
    num = dig+
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

 "72 + 8"
 `(expr (term (num (dig+ (dig "7") (dig+ (dig "2"))))) " " (add "+") " " (expr (term (num (dig+ (dig "8")))))))




;;;;;;;
;;
;; Multicharacter string usage
;;

(test-parser
 `( expr = choice
    choice = "aaa" / "bbb" )

 "aaa"
 '(expr (choice "aaa"))
 )


(test-parser
 `( expr = choice+
    choice = "aaa" / "bbb" )

 "aaa"
 '(expr (choice+ (choice "aaa"))))


(test-parser
 `( expr = choice+
    choice = "aaa" / "bbb" )

 "aaabbbaaabbb"
 '(expr (choice+
         (choice "aaa")
         (choice+
          (choice "bbb")
          (choice+
           (choice "aaa")
           (choice+
            (choice "bbb")))))))




(test-parser
 `( expr = choice+
    choice = "aaa" / "bbb" )

 "aaabbbaaaaaa"
 '(expr (choice+
         (choice "aaa")
         (choice+
          (choice "bbb")
          (choice+
           (choice "aaa")
           (choice+ (choice "aaa")))))))




(test-parser
 `( expr = choice+
    choice = "aaa" / "b" )

 "aaabbbaaabbaaa"
 '(expr (choice+
         (choice "aaa")
         (choice+
          (choice "b")
          (choice+
           (choice "b")
           (choice+
            (choice "b")
            (choice+
             (choice "aaa")
             (choice+
              (choice "b")
              (choice+
               (choice "b")
               (choice+
                (choice "aaa")))))))))))



(test-parser
 `( expr = term add expr / term
    add = "+"
    term = num / "!"
    num = dig+
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

 "42+8+!"

 '(expr (term (num (dig+ (dig "4") (dig+ (dig "2"))))) (add "+") (expr (term (num (dig+ (dig "8")))) (add "+") (expr (term "!")))))



(test-parser
 `( expr = term add expr / term
    add = "+"
    term = num / "!42"
    num = dig+
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

 "42+8+!42"

 '(expr (term (num (dig+ (dig "4")
                         (dig+ (dig "2")))))
        (add "+")
        (expr
         (term (num (dig+ (dig "8"))))
         (add "+")
         (expr (term "!42")))))



(assert-throw
 'parse-conflict

 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / "42"
      num = dig+
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"))))

;;;;;;;;;;;;;
;;
;; Single set cases
;;


(check-parser-result-and-reverse
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :join (dig)))

 "5+3"
 '(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3"))))))





(check-parser-result-and-reverse
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
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
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :join (expr)))

 "5+3"
 '(expr "5+3"))






(check-parser-result-and-reverse
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / id
      num = dig num / dig
      id = id1 / id1 num
      id1 = "x" / "y"
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :join (id)))

 "35+x7"
 `(expr (term (num (dig "3") (num (dig "5")))) (add "+") (expr (term (id "x7")))))






(check-parser-result-and-reverse
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / id
      num = num1
      num1 = dig num / dig
      id = id1 / id1 num
      id1 = "x" / "y"
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :join (id num1)))

 "35+x7"
 `(expr (term (num (num1 "35"))) (add "+") (expr (term (id "x7")))))





(assert-throw
 'invalid-set
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :join num)))





(assert-throw
 'invalid-set
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :skip (whatever))))






(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space num / num space / space num space
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :skip (space)))

 " 5 + 3 "
 `(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3"))))))




(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :skip (space)))

 "  5    + 3    "
 `(expr (term (space+ (space+)) (num (dig "5")) (space+ (space+ (space+ (space+))))) (add "+") (expr (term (space+) (num (dig "3")) (space+ (space+ (space+ (space+))))))))





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :flatten ()))

 "5+3"
 '(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3"))))))





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :flatten (expr)))

 "5+3"
 '(expr (term (num (dig "5"))) (add "+") (term (num (dig "3")))))





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (dig num)))

 "5+3"
 '(expr (term "5") (add "+") (expr (term "3"))))



(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (term)))

 "5+3"
 '(expr (num (dig "5")) (add "+") (expr (num (dig "3")))))




(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (num dig)))

 "54+3"
 '(expr (term "5" "4") (add "+") (expr (term "3"))))






;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Call instruction test
;;;



(test-parser
 `( expr = term add expr (call (list 'LEFT $1 $2 $3)) / term (call (list 'RIGHT $1))
    add = "+"
    term = num
    num = dig num / dig
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

 "5+3"

 '(LEFT (term (num (dig "5"))) (add "+") (RIGHT (term (num (dig "3")))))

 )





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr (call (+ $1 $3)) / term (call $1)
      add = "+"
      term = num (call (string->number (,parselynn:simple:join1 $1)))
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")))

 "42+777"

 (+ 42 777)

 )







(check-parser-result

 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr (call #t)
      /      term (call #t)
      add = "+" (call #t)
      term = NUM (call #t)
      NUM = "0" (call #t)
      /     "1" (call #t)
      /     "2" (call #t)
      /     "3" (call #t)
      /     "4" (call #t)
      /     "5" (call #t)
      /     "6" (call #t)
      /     "7" (call #t)
      /     "8" (call #t)
      /     "9" (call #t)
      )))

 "5+5"

 #t

 )




;;;;;;;;;;;;;
;;
;; Multiple set cases
;;

(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :flatten (term)
    :skip (space space+)))

 "  5    + 3    "
 '(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3"))))))





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :flatten (term)
    :skip (space space+)))

 "  5    + 3    "
 '(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3"))))))





(assert-throw
 'invalid-set
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :flatten num)))



(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :flatten (num term)
    :skip (space space+)))

 "  83712    + 371673    "

 '(expr (term (num (dig "8") (dig "3") (dig "7") (dig "1") (dig "2"))) (add "+") (expr (term (num (dig "3") (dig "7") (dig "1") (dig "6") (dig "7") (dig "3"))))))





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :join (term add)))

 "  83712    + 371673    "
 '(expr (term "  83712    ") (add "+") (expr (term " 371673    "))))




(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (term add)
    :join (term add)))

 "  83712    + 371673    "
 '(expr "  83712    " "+" (expr " 371673    ")))





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = num1
      num1 = dig num1 / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (term num1)
    :flatten (term)
    :join (num1)
    :skip (space space+)))

 "  83712    + 371673    "
 '(expr (num "83712") (add "+") (expr (num "371673"))))





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = num1
      num1 = dig num1 / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (term add)
    :join (term add)
    :skip (space space+)))

 "  83712    + 371673    "
 '(expr "83712" "+" (expr "371673")))






(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( root = expr
      expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = num1
      num1 = dig num1 / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (expr)
    :join (expr)
    :skip (space space+)))

 "  83712    + 371673    "
 '(root "83712+371673"))




(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = num1
      num1 = dig num1 / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (term add)
    :join (term add)
    :flatten (expr)
    :skip (space space+)))

 "  83712    + 371673    "
 '(expr "83712" "+" "371673"))




(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = num1
      num1 = dig num1 / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (num)
    :join (num)
    :flatten (term)
    :skip (space space+)))

 "  83712    + 371673    "
 '(expr (term "83712") (add "+") (expr (term "371673"))))






(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig+
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (num)
    :join (num)
    :flatten (term)
    :skip (space space+)))

 "  83712    + 371673    "
 '(expr (term "83712") (add "+") (expr (term "371673"))))





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig+
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = " ")

    :inline (expr num)
    :join (num)
    :flatten (term)
    :skip (space space+)))

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
 `( expr = term " " add " " expr / term
    add = "+" / "1"
    term = num
    num = dig+
    dig = (class numeric))

 "3 + 8"
 `(expr (term (num (dig+ (dig "3"))))
        " "
        (add "+")
        " "
        (expr (term (num (dig+ (dig "8")))))))




(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig+
      dig = (class numeric)
      space = (class whitespace))

    :inline (num)
    :join (num)
    :flatten (term)
    :skip (space space+)))

 "  83712    + 371673    "
 '(expr (term "83712") (add "+") (expr (term "371673"))))


(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig+
      dig = (class numeric)
      space = (class whitespace))

    :inline (add num)
    :join (num)
    :flatten (term)
    :skip (space space+)))

 "  83712    + 371673    "
 '(expr (term "83712") "+" (expr (term "371673"))))





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig+
      dig = (class numeric) / (class alphabetic)
      space = (class whitespace))

    :inline (add num)
    :join (num)
    :flatten (term)
    :skip (space space+)))

 "  83712b2    + 0x371673    "
 '(expr (term "83712b2") "+" (expr (term "0x371673"))))




(assert-throw
 'parse-conflict

 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig+
      dig = (class numeric) / (class alphabetic) / (class alphanum)
      space = (class whitespace))

    :inline (add num)
    :join (num)
    :flatten (term)
    :skip (space space+))))





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig+
      dig = (class alphanum)
      space = (class whitespace))

    :inline (add num)
    :join (num)
    :flatten (term)
    :skip (space space+)))

 "  83712b2    + 0x371673    "
 '(expr (term "83712b2") "+" (expr (term "0x371673"))))




(assert-throw
 'parse-conflict

 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig+
      dig = (class numeric) / (class numeric)
      space = (class whitespace))

    :inline (num)
    :join (num)
    :flatten (term)
    :skip (space space+))))





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig+
      dig = (class numeric)
      dig/unused = (class numeric)
      space = (class whitespace))

    :inline (num)
    :join (num)
    :flatten (term)
    :skip (space space+)))

 "  83712    + 371673    "
 '(expr (term "83712") (add "+") (expr (term "371673"))))




;;;;;;;;;;;;;;;;;;;
;;
;; Final pretty examples
;;




(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig+
      dig = (class numeric)
      space = (class whitespace))

    :inline (term)
    :join (num)
    :flatten (term expr)
    :skip (space space+)))

 "  83712    + 371673    "
 '(expr (num "83712") (add "+") (num "371673")))




(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = "+"
      term = num / space+ num / num space+ / space+ num space+
      num = dig+
      dig = (class numeric)
      space = (class whitespace))

    :inline (num term add)
    :join (num)
    :flatten (term expr)
    :skip (space space+)))

 "  83712    + 371673    "
 '(expr "83712" "+" "371673"))





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = (class (or (constant #\+) (constant #\-) (constant #\*) (constant #\/)))
      term = id / num
      id = idstart idcont / idstart
      idstart = (class alphabetic)
      idcont = idchar idcont / idchar
      idchar = (class (and alphanum (not (constant #\0))))
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

    :inline (num id term add)
    :join (num id)
    :flatten (term expr)
    ;; :skip (space space+)

    ))

 "42+x-y*42+x-y*42+x-y*42+x-y*42+x-y*42+x-y"
 '(expr "42" "+" "x" "-" "y" "*" "42" "+" "x" "-" "y" "*" "42" "+" "x" "-" "y" "*" "42" "+" "x" "-" "y" "*" "42" "+" "x" "-" "y" "*" "42" "+" "x" "-" "y"))




(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = (class (or (constant #\+) (constant #\-) (constant #\*) (constant #\/)))
      term = baseterm / space+ baseterm / baseterm space+ / space+ baseterm space+
      baseterm = id / num
      id = idstart idcont / idstart
      idstart = (class alphabetic)
      idcont = idchar idcont / idchar
      idchar = (class (and alphanum (not (constant #\0))))
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = (class whitespace)
      )

    :inline (num id term add baseterm)
    :join (num id)
    :flatten (term expr)
    :skip (space space+)

    ))

 " 42 + x2 -     y* 59 + x  "
 '(expr "42" "+" "x2" "-" "y" "*" "59" "+" "x"))





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = (class (or (constant #\+) (constant #\-) (constant #\*) (constant #\/)))
      term = baseterm / space+ baseterm / baseterm space+ / space+ baseterm space+
      baseterm = id / num / string
      id = idstart idcont / idstart
      idstart = (class alphabetic)
      idcont = idchar idcont / idchar
      idchar = (class (and alphanum (not (constant #\0))))
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = (class whitespace)
      string = "\"" string-inner* "\""
      string-inner = (class (and any (not (constant #\"))))
      )

    :inline (num id term string add baseterm)
    :join (num id string)
    :flatten (term expr)
    :skip (space space+)

    ))

 " 42 + x2 * \"good morning\" -     y* 59 + x  "
 '(expr "42" "+" "x2" "*" "\"good morning\"" "-" "y" "*" "59" "+" "x"))




(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term add expr / term
      add = (class (or (constant #\+) (constant #\-) (constant #\*) (constant #\/)))
      term = baseterm / space+ baseterm / baseterm space+ / space+ baseterm space+
      baseterm = id / num / string
      id = idstart idcont / idstart
      idstart = (class alphabetic)
      idcont = idchar idcont / idchar
      idchar = (class (and alphanum (not (constant #\0))))
      num = dig num / dig
      dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
      space = (class whitespace)
      string = "\"" string-inner* "\""
      string-inner = "\\" (class any)
      /              string-no-escape
      string-no-escape = (class (and any (not (constant #\")) (not (constant #\\))))
      )

    :inline (num id term string add baseterm)
    :join (num id string)
    :flatten (term expr)
    :skip (space space+)

    ))

 " 42 + x2 * \"good morning\" -     y* 59 + \"a \\\" quote\"  + x  "
 '(expr "42" "+" "x2" "*" "\"good morning\"" "-" "y" "*" "59" "+" "\"a \\\" quote\"" "+" "x"))




(test-parser
 ;; Test epsilon production [1].

 `( start = term cont
    cont = comma term cont /
    comma = "+"
    term = num
    num = dig num / dig
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

 "5+3"

 '(start (term (num (dig "5"))) (cont (comma "+") (term (num (dig "3"))) (cont)))

 )




(test-parser
 ;; Test epsilon production [2].

 `( start = term cont
    cont = / comma term cont
    comma = "+"
    term = num
    num = dig num / dig
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

 "5+3"

 '(start (term (num (dig "5"))) (cont (comma "+") (term (num (dig "3"))) (cont)))

 )


(test-parser
 ;; Test epsilon production [3].

 `( start = term cont
    cont = comma term cont / ""
    comma = "+"
    term = num
    num = dig num / dig
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

 "5+3"

 '(start (term (num (dig "5"))) (cont (comma "+") (term (num (dig "3"))) (cont "")))

 )




(test-parser
 ;; Test epsilon production [4].

 `( start = term cont
    cont = "" / comma term cont
    comma = "+"
    term = num
    num = dig num / dig
    dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

 "5+3"

 '(start (term (num (dig "5"))) (cont (comma "+") (term (num (dig "3"))) (cont "")))

 )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Test convinience syntax
;;


(test-parser
 `( expr = term add expr / term
    add = "+"
    term = num
    num = dig num / dig
    dig = (or "0" "1" "2" "3" "4" #\5 "6" (constant #\7) "8" "9"))

 "5+3"

 `(expr (term (num (dig "5"))) (add "+") (expr (term (num (dig "3"))))))




(test-parser
 `( expr = term operation expr / term
    operation = ".+." / ".-."
    term = num
    num = dig num / dig
    dig = (or "0" "1" "2" "3" "4" #\5 "6" (constant #\7) "8" "9"))

 "5.+.3.-.7"

 `(expr (term (num (dig "5"))) (operation ".+.") (expr (term (num (dig "3"))) (operation ".-.") (expr (term (num (dig "7")))))))





(test-parser
 `( expr = term operation expr / term
    operation = (or ".+." ".-.")
    term = num
    num = dig num / dig
    dig = (or "0" "1" "2" "3" "4" #\5 "6" (constant #\7) "8" "9"))

 "5.+.3.-.7"

 `(expr (term (num (dig "5"))) (operation ".+.") (expr (term (num (dig "3"))) (operation ".-.") (expr (term (num (dig "7")))))))




(test-parser
 `( expr = term operation expr / term
    operation = (and (or "+" "-" "*") (not "-"))
    term = num
    num = dig num / dig
    dig = (or "0" "1" "2" "3" "4" #\5 "6" (constant #\7) "8" "9"))

 "5+3+7"

 `(expr (term (num (dig "5"))) (operation "+") (expr (term (num (dig "3"))) (operation "+") (expr (term (num (dig "7"))))))

 )




(test-parser-error
 `( expr = term operation expr / term
    operation = (and (or "+" "-" "*") (not "-"))
    term = num
    num = dig num / dig
    dig = (or "0" "1" "2" "3" "4" #\5 "6" (constant #\7) "8" "9"))

 "5+3-7"

 )





(test-parser
 `( expr = term operation expr / term
    operation = (and (or ".+." ".-." ".*.") (not ".-."))
    term = num
    num = dig num / dig
    dig = (or "0" "1" "2" "3" "4" #\5 "6" (constant #\7) "8" "9"))

 "5.+.3.*.7"

 `(expr (term (num (dig "5")))
        (operation ".+.")
        (expr (term (num (dig "3")))
              (operation ".*.")
              (expr (term (num (dig "7"))))))

 )



(test-parser-error
 `( expr = term operation expr / term
    operation = (and (or ".+." ".-." ".*.") (not ".-."))
    term = num
    num = dig num / dig
    dig = (or "0" "1" "2" "3" "4" #\5 "6" (constant #\7) "8" "9"))

 "5.+.3.-.7"

 )




;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Test non-string.
;;



(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term operation expr / term
      operation = (constant '+)
      term = num
      num = dig num / dig
      dig = (or (constant 0)
                (constant 1)
                (constant 2)
                (constant 3)
                (constant 4)
                (constant 5)
                (constant 6)
                (constant 7)
                (constant 8)
                (constant 9)))))

 (input-stream
  '(5   +   3))

 `(expr (term (num (dig 5)))
        (operation +)
        (expr (term (num (dig 3)))))

 )





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( expr = term operation expr / term
      operation = ".+."
      term = num
      num = dig num / dig
      dig = (or (constant 0)
                (constant 1)
                (constant 2)
                (constant 3)
                (constant 4)
                (constant 5)
                (constant 6)
                (constant 7)
                (constant 8)
                (constant 9)))))

 (input-stream
  '(5 #\. #\+ #\. 3))

 `(expr (term (num (dig 5)))
        (operation ".+.")
        (expr (term (num (dig 3)))))

 )





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( stream = category+
      category = even / odd
      even = (r7rs even?)
      odd = (r7rs odd?)
      )))

 (input-stream
  '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19))

 '(stream (category+ (category (odd 1)) (category+ (category (even 2)) (category+ (category (odd 3)) (category+ (category (even 4)) (category+ (category (odd 5)) (category+ (category (even 6)) (category+ (category (odd 7)) (category+ (category (even 8)) (category+ (category (odd 9)) (category+ (category (even 10)) (category+ (category (odd 11)) (category+ (category (even 12)) (category+ (category (odd 13)) (category+ (category (even 14)) (category+ (category (odd 15)) (category+ (category (even 16)) (category+ (category (odd 17)) (category+ (category (even 18)) (category+ (category (odd 19))))))))))))))))))))))

 )






(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( stream = category+
      category = fizz / buzz / fizzbuzz / none

      fizz = (r7rs (lambda (n)
                     (and (= 0 (modulo n 3))
                          (not (= 0 (modulo n 5))))))
      buzz = (r7rs (lambda (n)
                     (and (= 0 (modulo n 5))
                          (not (= 0 (modulo n 3))))))
      fizzbuzz = (r7rs (lambda (n)
                         (and (= 0 (modulo n 3))
                              (= 0 (modulo n 5)))))

      none = (r7rs (lambda (n)
                     (not (or (= 0 (modulo n 3))
                              (= 0 (modulo n 5)))))))

    :flatten (stream)
    :inline (category category+)
    :skip (none)

    ))

 (input-stream
  '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19))

 '(stream (fizz 3) (buzz 5) (fizz 6) (fizz 9)
          (buzz 10) (fizz 12) (fizzbuzz 15) (fizz 18))

 )




;;;;;;;;;;;;
;;
;; Lexer classes definitions tests.
;;





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( stream = category+
      category = pos / neg
      pos = (r7rs positive?)
      neg = (r7rs negative?)
      )))

 (input-stream
  '(-5 -4 -3 -2 -1 +1 +2 +3 +4 +5))

 '(stream (category+ (category (neg -5)) (category+ (category (neg -4)) (category+ (category (neg -3)) (category+ (category (neg -2)) (category+ (category (neg -1)) (category+ (category (pos 1)) (category+ (category (pos 2)) (category+ (category (pos 3)) (category+ (category (pos 4)) (category+ (category (pos 5)))))))))))))

 )





(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( stream = category+
      category = pos / neg / zero
      pos = (r7rs positive?)
      neg = (r7rs negative?)
      zero = (and (not (class pos))
                  (not (class neg)))
      )))

 (input-stream
  '(-5 -4 -3 -2 -1 0 +1 +2 +3 +4 +5))

 '(stream (category+ (category (neg -5)) (category+ (category (neg -4)) (category+ (category (neg -3)) (category+ (category (neg -2)) (category+ (category (neg -1)) (category+ (category (zero 0)) (category+ (category (pos 1)) (category+ (category (pos 2)) (category+ (category (pos 3)) (category+ (category (pos 4)) (category+ (category (pos 5))))))))))))))

 )




(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( stream = category+
      category = pos / neg / zero
      pos = (r7rs positive?) (call 'pos)
      neg = (r7rs negative?) (call 'neg)
      zero = (and (not (class pos))
                  (not (class neg)))
      )))

 (input-stream
  '(-5 -4 -3 -2 -1 0 +1 +2 +3 +4 +5))

 '(stream (category+ (category neg) (category+ (category neg) (category+ (category neg) (category+ (category neg) (category+ (category neg) (category+ (category (zero 0)) (category+ (category pos) (category+ (category pos) (category+ (category pos) (category+ (category pos) (category+ (category pos)))))))))))))

 )




(check-parser-result
 (parselynn:simple
  `(:driver (LR 1)
    :grammar
    ( stream = category+
      category = fizz / buzz / fizzbuzz / none

      fizz = (r7rs (lambda (n)
                     (and (= 0 (modulo n 3))
                          (not (= 0 (modulo n 5))))))
      buzz = (r7rs (lambda (n)
                     (and (= 0 (modulo n 5))
                          (not (= 0 (modulo n 3))))))
      fizzbuzz = (r7rs (lambda (n)
                         (and (= 0 (modulo n 3))
                              (= 0 (modulo n 5)))))

      none = (not (or (class fizz) (class buzz) (class fizzbuzz))))

    :flatten (stream)
    :inline (category category+)
    :skip (none)

    ))

 (input-stream
  '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19))

 '(stream (fizz 3) (buzz 5) (fizz 6) (fizz 9)
          (buzz 10) (fizz 12) (fizzbuzz 15) (fizz 18))

 )

