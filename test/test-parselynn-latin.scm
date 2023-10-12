
(define make-lexer make-parselynn/latin)

(define (make-test-parser parser-rules)
   (parselynn
    `((tokens: ,@parselynn/latin-tokens)
      (rules: ,@parser-rules))))

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
  (parselynn-run parser (make-lexer input)))

(define save list)

;;;;;;;;;;;;;;;;
;; TEST CASES ;;
;;;;;;;;;;;;;;;;




(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (<+) : (,save 'add $1))
   (term     (num) : (,save 'term $1))
   (num      (dig num) : (,save 'num $1 $2)
             (dig) : (,save 'num $1))
   (dig      (<0) : $1 (<1) : $1 (<2) : $1 (<3) : $1 (<4) : $1
             (<5) : $1 (<6) : $1 (<7) : $1 (<8) : $1 (<9) : $1))

 "5+3"

 '(expr (term (num #\5)) (add #\+) (expr (term (num #\3)))))





(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (<+) : (,save 'add $1))
   (term     (num) : (,save 'term $1))
   (num      (dig num) : (,save 'num $1 $2)
             (dig) : (,save 'num $1))
   (dig      ,@parselynn/latin/digits))

 "5+3"

 '(expr (term (num #\5)) (add #\+) (expr (term (num #\3)))))





(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (<+) : (,save 'add $1))
   (term     (num) : (,save 'term $1))
   (num      (dig num) : (,save 'num $1 $2)
             (dig) : (,save 'num $1))
   (dig      ,@parselynn/latin/digits))

 "47+3732"

 '(expr (term (num #\4 (num #\7))) (add #\+) (expr (term (num #\3 (num #\7 (num #\3 (num #\2))))))))




(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (<+) : (,save 'add $1))
   (term     (num) : (,save 'term $1)
             (id) : (,save 'term $1))
   (num      (dig num) : (,save 'num $1 $2)
             (dig) : (,save 'num $1))
   (id       (alpha idcont) : (,save 'id $1 $2))
   (idcont   (idcont alphanum) : (,save 'idcont $1 $2)
             (alphanum) : (,save 'idcont $1))
   (alphanum (alpha) : $1
             (dig) : $1)
   (alpha    ,@parselynn/latin/letters)
   (dig      ,@parselynn/latin/digits))

 "47+3732"

 '(expr (term (num #\4 (num #\7))) (add #\+) (expr (term (num #\3 (num #\7 (num #\3 (num #\2))))))))






(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (<+) : (,save 'add $1))
   (term     (num) : (,save 'term $1)
             (id) : (,save 'term $1))
   (num      (dig num) : (,save 'num $1 $2)
             (dig) : (,save 'num $1))
   (id       (alpha idcont) : (,save 'id $1 $2))
   (idcont   (idcont alphanum) : (,save 'idcont $1 $2)
             (alphanum) : (,save 'idcont $1))
   (alphanum (alpha) : $1
             (dig) : $1)
   (alpha    ,@parselynn/latin/letters)
   (dig      ,@parselynn/latin/digits))

 "47+x3"

 '(expr (term (num #\4 (num #\7))) (add #\+) (expr (term (id #\x (idcont #\3))))))




(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (<+) : (,save 'add $1))
   (term     (num) : (,save 'term $1)
             (id) : (,save 'term $1))
   (num      (dig num) : (,save 'num $1 $2)
             (dig) : (,save 'num $1))
   (id       (alpha idcont) : (,save 'id $1 $2))
   (idcont   (idcont alphanum) : (,save 'idcont $1 $2)
             (alphanum) : (,save 'idcont $1))
   (alphanum (alpha) : $1
             (dig) : $1)
   (alpha    ,@parselynn/latin/letters)
   (dig      ,@parselynn/latin/digits)
   (space    (<SPACE) : $1
             (<TAB) : $1))

 "47+x3"

 '(expr (term (num #\4 (num #\7))) (add #\+) (expr (term (id #\x (idcont #\3))))))




(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (<+) : (,save 'add $1))
   (term     (num) : (,save 'term $1)
             (id) : (,save 'term $1)
             (space term) : (,save 'term $1 $2)
             (term space) : (,save 'term $1 $2))
   (num      (dig num) : (,save 'num $1 $2)
             (dig) : (,save 'num $1))
   (id       (alpha idcont) : (,save 'id $1 $2))
   (idcont   (idcont alphanum) : (,save 'idcont $1 $2)
             (alphanum) : (,save 'idcont $1))
   (alphanum (alpha) : $1
             (dig) : $1)
   (alpha    ,@parselynn/latin/letters)
   (dig      ,@parselynn/latin/digits)
   (space    (<SPACE) : $1
             (<TAB) : $1))

 "47+x3"

 '(expr (term (num #\4 (num #\7))) (add #\+) (expr (term (id #\x (idcont #\3))))))





(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (<+) : (,save 'add $1))
   (term     (num) : (,save 'term $1)
             (id) : (,save 'term $1)
             (space term) : (,save 'term $1 $2)
             (term space) : (,save 'term $1 $2))
   (num      (dig num) : (,save 'num $1 $2)
             (dig) : (,save 'num $1))
   (id       (alpha idcont) : (,save 'id $1 $2))
   (idcont   (idcont alphanum) : (,save 'idcont $1 $2)
             (alphanum) : (,save 'idcont $1))
   (alphanum (alpha) : $1
             (dig) : $1)
   (alpha    ,@parselynn/latin/letters)
   (dig      ,@parselynn/latin/digits)
   (space    (<SPACE) : $1
             (<TAB) : $1))

 "47 + x3"

 '(expr (term (term (num #\4 (num #\7))) #\space) (add #\+) (expr (term #\space (term (id #\x (idcont #\3)))))))




(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (<+) : (,save 'add $1))
   (term     (num) : (,save 'term $1)
             (id) : (,save 'term $1)
             (space term) : (,save 'term $1 $2)
             (term space) : (,save 'term $1 $2))
   (num      (dig num) : (,save 'num $1 $2)
             (dig) : (,save 'num $1))
   (id       (alpha idcont) : (,save 'id $1 $2))
   (idcont   (idcont alphanum) : (,save 'idcont $1 $2)
             (alphanum) : (,save 'idcont $1))
   (alphanum (alpha) : $1
             (dig) : $1)
   (alpha    ,@parselynn/latin/letters)
   (dig      ,@parselynn/latin/digits)
   (space    (<SPACE) : $1
             (<TAB) : $1))

 "   47 +x3   "

 '(expr (term #\space (term #\space (term #\space (term (term (num #\4 (num #\7))) #\space)))) (add #\+) (expr (term (term (term (term (id #\x (idcont #\3))) #\space) #\space) #\space))))




(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (<+) : (,save 'add $1))
   (term     (num) : (,save 'term $1)
             (id) : (,save 'term $1)
             (space* term space*) : (,save 'term $1 $2))
   (num      (dig num) : (,save 'num $1 $2)
             (dig) : (,save 'num $1))
   (id       (alpha idcont) : (,save 'id $1 $2))
   (idcont   (idcont alphanum) : (,save 'idcont $1 $2)
             (alphanum) : (,save 'idcont $1))
   (alphanum (alpha) : $1
             (dig) : $1)
   (alpha    ,@parselynn/latin/letters)
   (dig      ,@parselynn/latin/digits)
   (space*   (space space*) : $1 ())
   (space    (<SPACE) : $1
             (<TAB) : $1))

 "   47 +  x3   "

 '(expr (term #\space (term (num #\4 (num #\7)))) (add #\+) (expr (term #\space (term (id #\x (idcont #\3)))))))


