
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




(test-parser
 `( expr : term add expr / term
    add : <+
    term : num
    num : dig num / dig
    dig : <0 / <1 / <2 / <3 / <4 / <5 / <6 / <7 / <8 / <9)

 "5+3"

 #(expr #(term #(num #(dig #\5))) #(add #\+) #(expr #(term #(num #(dig #\3))))))





;; (test-parser
;;  `((expr     (term add expr) : (,save 'expr $1 $2 $3)
;;              (term) : (,save 'expr $1))
;;    (add      (<+) : (,save 'add $1))
;;    (term     (num) : (,save 'term $1))
;;    (num      (dig num) : (,save 'num $1 $2)
;;              (dig) : (,save 'num $1))
;;    (dig      ,@lalr-lexer/latin/digits))

;;  "5+3"

;;  '(expr (term (num #\5)) (add #\+) (expr (term (num #\3)))))





;; (test-parser
;;  `((expr     (term add expr) : (,save 'expr $1 $2 $3)
;;              (term) : (,save 'expr $1))
;;    (add      (<+) : (,save 'add $1))
;;    (term     (num) : (,save 'term $1))
;;    (num      (dig num) : (,save 'num $1 $2)
;;              (dig) : (,save 'num $1))
;;    (dig      ,@lalr-lexer/latin/digits))

;;  "47+3732"

;;  '(expr (term (num #\4 (num #\7))) (add #\+) (expr (term (num #\3 (num #\7 (num #\3 (num #\2))))))))




;; (test-parser
;;  `((expr     (term add expr) : (,save 'expr $1 $2 $3)
;;              (term) : (,save 'expr $1))
;;    (add      (<+) : (,save 'add $1))
;;    (term     (num) : (,save 'term $1)
;;              (id) : (,save 'term $1))
;;    (num      (dig num) : (,save 'num $1 $2)
;;              (dig) : (,save 'num $1))
;;    (id       (alpha idcont) : (,save 'id $1 $2))
;;    (idcont   (idcont alphanum) : (,save 'idcont $1 $2)
;;              (alphanum) : (,save 'idcont $1))
;;    (alphanum (alpha) : $1
;;              (dig) : $1)
;;    (alpha    ,@lalr-lexer/latin/letters)
;;    (dig      ,@lalr-lexer/latin/digits))

;;  "47+3732"

;;  '(expr (term (num #\4 (num #\7))) (add #\+) (expr (term (num #\3 (num #\7 (num #\3 (num #\2))))))))






;; (test-parser
;;  `((expr     (term add expr) : (,save 'expr $1 $2 $3)
;;              (term) : (,save 'expr $1))
;;    (add      (<+) : (,save 'add $1))
;;    (term     (num) : (,save 'term $1)
;;              (id) : (,save 'term $1))
;;    (num      (dig num) : (,save 'num $1 $2)
;;              (dig) : (,save 'num $1))
;;    (id       (alpha idcont) : (,save 'id $1 $2))
;;    (idcont   (idcont alphanum) : (,save 'idcont $1 $2)
;;              (alphanum) : (,save 'idcont $1))
;;    (alphanum (alpha) : $1
;;              (dig) : $1)
;;    (alpha    ,@lalr-lexer/latin/letters)
;;    (dig      ,@lalr-lexer/latin/digits))

;;  "47+x3"

;;  '(expr (term (num #\4 (num #\7))) (add #\+) (expr (term (id #\x (idcont #\3))))))




;; (test-parser
;;  `((expr     (term add expr) : (,save 'expr $1 $2 $3)
;;              (term) : (,save 'expr $1))
;;    (add      (<+) : (,save 'add $1))
;;    (term     (num) : (,save 'term $1)
;;              (id) : (,save 'term $1))
;;    (num      (dig num) : (,save 'num $1 $2)
;;              (dig) : (,save 'num $1))
;;    (id       (alpha idcont) : (,save 'id $1 $2))
;;    (idcont   (idcont alphanum) : (,save 'idcont $1 $2)
;;              (alphanum) : (,save 'idcont $1))
;;    (alphanum (alpha) : $1
;;              (dig) : $1)
;;    (alpha    ,@lalr-lexer/latin/letters)
;;    (dig      ,@lalr-lexer/latin/digits)
;;    (space    (<SPACE) : $1
;;              (<TAB) : $1))

;;  "47+x3"

;;  '(expr (term (num #\4 (num #\7))) (add #\+) (expr (term (id #\x (idcont #\3))))))




;; (test-parser
;;  `((expr     (term add expr) : (,save 'expr $1 $2 $3)
;;              (term) : (,save 'expr $1))
;;    (add      (<+) : (,save 'add $1))
;;    (term     (num) : (,save 'term $1)
;;              (id) : (,save 'term $1)
;;              (space term) : (,save 'term $1 $2)
;;              (term space) : (,save 'term $1 $2))
;;    (num      (dig num) : (,save 'num $1 $2)
;;              (dig) : (,save 'num $1))
;;    (id       (alpha idcont) : (,save 'id $1 $2))
;;    (idcont   (idcont alphanum) : (,save 'idcont $1 $2)
;;              (alphanum) : (,save 'idcont $1))
;;    (alphanum (alpha) : $1
;;              (dig) : $1)
;;    (alpha    ,@lalr-lexer/latin/letters)
;;    (dig      ,@lalr-lexer/latin/digits)
;;    (space    (<SPACE) : $1
;;              (<TAB) : $1))

;;  "47+x3"

;;  '(expr (term (num #\4 (num #\7))) (add #\+) (expr (term (id #\x (idcont #\3))))))





;; (test-parser
;;  `((expr     (term add expr) : (,save 'expr $1 $2 $3)
;;              (term) : (,save 'expr $1))
;;    (add      (<+) : (,save 'add $1))
;;    (term     (num) : (,save 'term $1)
;;              (id) : (,save 'term $1)
;;              (space term) : (,save 'term $1 $2)
;;              (term space) : (,save 'term $1 $2))
;;    (num      (dig num) : (,save 'num $1 $2)
;;              (dig) : (,save 'num $1))
;;    (id       (alpha idcont) : (,save 'id $1 $2))
;;    (idcont   (idcont alphanum) : (,save 'idcont $1 $2)
;;              (alphanum) : (,save 'idcont $1))
;;    (alphanum (alpha) : $1
;;              (dig) : $1)
;;    (alpha    ,@lalr-lexer/latin/letters)
;;    (dig      ,@lalr-lexer/latin/digits)
;;    (space    (<SPACE) : $1
;;              (<TAB) : $1))

;;  "47 + x3"

;;  '(expr (term (term (num #\4 (num #\7))) #\space) (add #\+) (expr (term #\space (term (id #\x (idcont #\3)))))))




;; (test-parser
;;  `((expr     (term add expr) : (,save 'expr $1 $2 $3)
;;              (term) : (,save 'expr $1))
;;    (add      (<+) : (,save 'add $1))
;;    (term     (num) : (,save 'term $1)
;;              (id) : (,save 'term $1)
;;              (space term) : (,save 'term $1 $2)
;;              (term space) : (,save 'term $1 $2))
;;    (num      (dig num) : (,save 'num $1 $2)
;;              (dig) : (,save 'num $1))
;;    (id       (alpha idcont) : (,save 'id $1 $2))
;;    (idcont   (idcont alphanum) : (,save 'idcont $1 $2)
;;              (alphanum) : (,save 'idcont $1))
;;    (alphanum (alpha) : $1
;;              (dig) : $1)
;;    (alpha    ,@lalr-lexer/latin/letters)
;;    (dig      ,@lalr-lexer/latin/digits)
;;    (space    (<SPACE) : $1
;;              (<TAB) : $1))

;;  "   47 +x3   "

;;  '(expr (term #\space (term #\space (term #\space (term (term (num #\4 (num #\7))) #\space)))) (add #\+) (expr (term (term (term (term (id #\x (idcont #\3))) #\space) #\space) #\space))))




;; (test-parser
;;  `((expr     (term add expr) : (,save 'expr $1 $2 $3)
;;              (term) : (,save 'expr $1))
;;    (add      (<+) : (,save 'add $1))
;;    (term     (num) : (,save 'term $1)
;;              (id) : (,save 'term $1)
;;              (space* term space*) : (,save 'term $1 $2))
;;    (num      (dig num) : (,save 'num $1 $2)
;;              (dig) : (,save 'num $1))
;;    (id       (alpha idcont) : (,save 'id $1 $2))
;;    (idcont   (idcont alphanum) : (,save 'idcont $1 $2)
;;              (alphanum) : (,save 'idcont $1))
;;    (alphanum (alpha) : $1
;;              (dig) : $1)
;;    (alpha    ,@lalr-lexer/latin/letters)
;;    (dig      ,@lalr-lexer/latin/digits)
;;    (space*   (space space*) : $1 ())
;;    (space    (<SPACE) : $1
;;              (<TAB) : $1))

;;  "   47 +  x3   "

;;  '(expr (term #\space (term (num #\4 (num #\7)))) (add #\+) (expr (term #\space (term (id #\x (idcont #\3)))))))
