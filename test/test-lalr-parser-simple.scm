
(define (error-procedure type/subtype message-fmt token)
  (raisu* :type (car type/subtype)
          :message (stringf message-fmt token)
          :args (list (cdr type/subtype) token)))

(define (make-test-parser parser-rules)
   (lalr-parser/simple
    `(:rules ,parser-rules)))

(define (test-parser parser-rules input expected-output)
  (define parser
    (make-test-parser parser-rules))

  (define result
    (run-input parser input))

  (assert= result expected-output))

(define (test-parser-error parser-rules input)
  (define parser
    (make-test-parser parser-rules))

  (assert-throw
   'parse-error
   (run-input parser input)))

(define (run-input parser input)
  (with-string-as-input
   input (parser error-procedure)))

(define save list)

;;;;;;;;;;;;;;;;
;; TEST CASES ;;
;;;;;;;;;;;;;;;;



(lalr-parser/simple
 `(:rules
   ( expr ::= t_term add expr / t_term
     add ::= "+"
     t_term ::= num
     num ::= dig num / dig
     dig ::= "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")))




(test-parser
 `( expr ::= term add expr / term
    add ::= "+"
    term ::= num
    num ::= dig num / dig
    dig ::= "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

 "5+3"
 #(expr #(term #(num #(dig "5"))) #(add "+") #(expr #(term #(num #(dig "3"))))))





(test-parser
 `( expr ::= term add expr / term
    add ::= "+" / space add / add space
    term ::= num / space term / term space
    num ::= dig num / dig
    dig ::= "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
    space ::= " ")

 " 5 + 3 "

 #(expr #(term #(space " ") #(term #(term #(num #(dig "5"))) #(space " "))) #(add "+") #(expr #(term #(space " ") #(term #(term #(num #(dig "3"))) #(space " "))))))

