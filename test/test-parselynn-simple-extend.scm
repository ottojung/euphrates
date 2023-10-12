
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

(define (run-input parser input)
  (parselynn/simple:run/with-error-handler
   parser error-procedure input))


;;;;;;;
;;
;; Sanity check
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

    :inline (num term add)
    :join (num)
    :flatten (term expr)
    :skip (space)))

 "  83712    + 371673    "
 '(expr "83712" "+" "371673"))




;;;;;;;;;;;;;;;;
;; TEST CASES ;;
;;;;;;;;;;;;;;;;



(assert=

 '(:inline (expr identifier num term add)
   :skip (space)
   :join (identifier num)
   :flatten (term expr)
   :grammar
   ( expr2 = expr
     term = identifier
     identifier = letter+
     letter = (class alphabetic)
     expr = term add expr / term
     add = "+" / space add / add space
     term = num / space term / term space
     num = dig+
     dig = (class numeric)
     space = (class whitespace)))

 (parselynn/simple:extend

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
    :skip (space))

  `(:grammar
    ( expr2 = expr
      term = identifier
      identifier = letter+
      letter = (class alphabetic)
      )
    :join (identifier)
    :inline (expr identifier))))



(check-parser-result
 (parselynn/simple:extend

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

  `(:grammar
    ( expr2 = expr )
    :inline (expr)))

 "  83712    + 371673    "
 '(expr2 "83712" "+" "371673"))



(check-parser-result
 (parselynn/simple:extend

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

  `(:grammar
    ( expr2 = expr
      term = identifier
      identifier = letter+
      letter = (class alphabetic)
      )
    :join (identifier)
    :inline (expr identifier)))

 "  83712    + 371673  + xy   "
 '(expr2 "83712" "+" "371673" "+" "xy"))


