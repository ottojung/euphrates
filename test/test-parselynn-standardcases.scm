
(define (collect-iterator iter)
  (let loop ((buf '()))
    (define x (iter))
    (if x
        (loop (cons x buf))
        buf)))

(define (make-lexer)
  (lambda ()
    (letrec ((read-number
              (lambda (l)
                (let ((c (peek-char)))
                  (if (and (char? c) (char-numeric? c))
                      (read-number (cons (read-char) l))
                      (string->number (apply string (reverse l)))))))
             (read-id
              (lambda (l)
                (let ((c (peek-char)))
                  (if (and (char? c)
                           (or (char-alphabetic? c)
                               (char-numeric? c)))
                      (read-id (cons (read-char) l))
                      (apply string (reverse l)))))))

      ;; -- read the next token
      (let loop ()
        (let* ((location (make-source-location "*stdin*" 'unknown-line 'unknown-column -1 -1))
               (c (read-char)))
          (cond ((eof-object? c)      '*eoi*)
                ((char=? c #\newline) (make-lexical-token 'NEWLINE location 'NEWLINE))
                ((char-whitespace? c) (make-lexical-token 'SPACE   location 'SPACE))
                ((char=? c #\+)       (make-lexical-token '+       location (string c)))
                ((char=? c #\-)       (make-lexical-token '-       location (string c)))
                ((char=? c #\*)       (make-lexical-token '*       location (string c)))
                ((char=? c #\/)       (make-lexical-token '/       location (string c)))
                ((char=? c #\=)       (make-lexical-token '=       location (string c)))
                ((char=? c #\,)       (make-lexical-token 'COMMA   location (string c)))
                ((char=? c #\()       (make-lexical-token 'LPAREN  location (string c)))
                ((char=? c #\))       (make-lexical-token 'RPAREN  location (string c)))
                ((char-numeric? c)    (make-lexical-token 'NUM     location (read-number (list c))))
                ((char-alphabetic? c) (make-lexical-token 'ID      location (read-id (list c))))
                (else
                 (raisu
                  'lex-error
                  (stringf "PARSE ERROR : illegal character: ~s" c)
                  c)
                 (loop))))))))

(define glr-parser?/p
  (make-parameter #f))

(define (make-test-parser parser-rules)
  (parselynn
   `((driver: ,(if (glr-parser?/p) 'glr 'lr))
     (results: ,(if (glr-parser?/p) 'all 'first))
     (on-conflict: ,ignore)
     (tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
     (rules: ,@parser-rules))))

(define (also-test-respective-glr parser-rules input expected-output)
  (define conflicting-glr? #f)
  (define parser/glr/first
    (parselynn
     `((driver: glr)
       (results: first)
       (on-conflict: ,(lambda _ (set! conflicting-glr? #t)))
       (tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules: ,@parser-rules))))

  (unless conflicting-glr?
    (let ()
      (define result/glr/first
        (run-input parser/glr/first input))

      (assert= expected-output result/glr/first))))

(define (test-parser parser-rules input expected-output)
  (define parser
    (make-test-parser parser-rules))

  (define result
    (run-input parser input))

  (assert= expected-output result)

  (unless (glr-parser?/p)
    (also-test-respective-glr parser-rules input expected-output)))


(define (test-parser-error parser-rules input)
  (define parser
    (make-test-parser parser-rules))

  (assert-throw
   'parse-error
   (run-input parser input)))

(define (run-input parser input)
  (with-string-as-input
   input

   (if (glr-parser?/p)
       (let ()
         (define iter (parselynn-run parser (make-lexer)))
         (collect-iterator iter))
       (parselynn-run parser (make-lexer)))))

(define save list)

;;;;;;;;;;;;;;;;
;; TEST CASES ;;
;;;;;;;;;;;;;;;;

(test-parser
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace NUM mspace) : (,save 'term $1 $2 $3))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "5+3"

 '(expr (expr (term (mspace) 5 (mspace))) (add (mspace) "+" (mspace)) (term (mspace) 3 (mspace))))

(test-parser
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace NUM mspace) : (,save 'term $1 $2 $3))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "5 + 3"

 '(expr (expr (term (mspace) 5 (mspace SPACE (mspace)))) (add (mspace) "+" (mspace SPACE (mspace))) (term (mspace) 3 (mspace))))

(test-parser
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace NUM mspace) : (,save 'term $1 $2 $3))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "54 + 382176"

 '(expr (expr (term (mspace) 54 (mspace SPACE (mspace)))) (add (mspace) "+" (mspace SPACE (mspace))) (term (mspace) 382176 (mspace))))

(test-parser
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace NUM mspace) : (,save 'term $1 $2 $3))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "  5   + 3  "

 '(expr (expr (term (mspace SPACE (mspace SPACE (mspace))) 5 (mspace SPACE (mspace SPACE (mspace SPACE (mspace)))))) (add (mspace) "+" (mspace SPACE (mspace))) (term (mspace) 3 (mspace SPACE (mspace SPACE (mspace))))))

(test-parser
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace NUM mspace) : (,save 'term $1 $2 $3))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "5 + 3 + 4 + 7"

 '(expr (expr (expr (expr (term (mspace) 5 (mspace SPACE (mspace)))) (add (mspace) "+" (mspace SPACE (mspace))) (term (mspace) 3 (mspace SPACE (mspace)))) (add (mspace) "+" (mspace SPACE (mspace))) (term (mspace) 4 (mspace SPACE (mspace)))) (add (mspace) "+" (mspace SPACE (mspace))) (term (mspace) 7 (mspace))))

(test-parser
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace NUM mspace) : (,save 'term $1 $2 $3))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "5"

 '(expr (term (mspace) 5 (mspace))))

(test-parser-error
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace NUM mspace) : (,save 'term $1 $2 $3))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "5 +")

(test-parser-error
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace NUM mspace) : (,save 'term $1 $2 $3))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "5+4+")

(test-parser-error
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace NUM mspace) : (,save 'term $1 $2 $3))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "")

(test-parser
 `((funcall  (ID LPAREN args RPAREN) : (,save 'funcall $1 $2 $3 $4))
   (args     (args COMMA mspace arg) : (,save 'args $1 $2 $3)
             (arg) : (,save 'args $1))
   (arg      (ID) : (,save 'arg $1)
             (NUM) : (,save 'arg $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "func(1,x,y,3)"

 '(funcall "func" "(" (args (args (args (args (arg 1)) "," (mspace)) "," (mspace)) "," (mspace)) ")"))

(test-parser
 `((funcall  (ID LPAREN args RPAREN) : (,save 'funcall $1 $2 $3 $4))
   (args     (args COMMA mspace arg) : (,save 'args $1 $2 $3)
             (arg) : (,save 'args $1))
   (arg      (ID) : (,save 'arg $1)
             (NUM) : (,save 'arg $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "func(1, x, y, 3)"

 '(funcall "func" "(" (args (args (args (args (arg 1)) "," (mspace SPACE (mspace))) "," (mspace SPACE (mspace))) "," (mspace SPACE (mspace))) ")"))

(test-parser
 `((funcall  (ID LPAREN args RPAREN) : (,save 'funcall $1 $2 $3 $4))
   (args     (args COMMA mspace arg) : (,save 'args $1 $2 $3)
             (arg) : (,save 'args $1))
   (arg      (ID) : (,save 'arg $1)
             (NUM) : (,save 'arg $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "func(1,    x,y,3)"

 '(funcall "func" "(" (args (args (args (args (arg 1)) "," (mspace SPACE (mspace SPACE (mspace SPACE (mspace SPACE (mspace)))))) "," (mspace)) "," (mspace)) ")"))

(test-parser-error
 `((funcall  (ID LPAREN args RPAREN) : (,save 'funcall $1 $2 $3 $4))
   (args     (args COMMA mspace arg) : (,save 'args $1 $2 $3)
             (arg) : (,save 'args $1))
   (arg      (ID) : (,save 'arg $1)
             (NUM) : (,save 'arg $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "func(1,x ,y ,3)")

(test-parser-error
 `((funcall  (ID LPAREN args RPAREN) : (,save 'funcall $1 $2 $3 $4))
   (args     (args COMMA mspace arg) : (,save 'args $1 $2 $3)
             (arg) : (,save 'args $1))
   (arg      (ID) : (,save 'arg $1)
             (NUM) : (,save 'arg $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "   func(1,x,y,3)    ")

(test-parser
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace term mspace) : (,save 'term $1 $2 $3)
             (LPAREN term RPAREN) : (,save 'term $1 $2 $3)
             (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "9 + 2"

 '(expr (expr (term 9)) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (term 2)))

(test-parser
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace term mspace) : (,save 'term $1 $2 $3)
             (LPAREN term RPAREN) : (,save 'term $1 $2 $3)
             (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "9 + 2"

 '(expr (expr (term 9)) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (term 2)))

(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (+) : (,save 'add $1))
   (term     (LPAREN NUM RPAREN) : (,save 'term $1 $2 $3)
             (NUM) : (,save 'term $1)))

 "9+(6)+(8)"

 '(expr (term 9) (add "+") (expr (term "(" 6 ")") (add "+") (expr (term "(" 8 ")")))))

(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (+) : (,save 'add $1))
   (term     (NUM) : (,save 'term $1)))

 "9+(6+8)"

 '(expr (term 9) (add "+") (expr "(" (expr (term 6) (add "+") (expr (term 8))) ")")))

(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
             (mspace expr mspace) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace term mspace) : (,save 'term $1 $2 $3)
             (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "9 + (6 + 8)"

 '(expr (term 9) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (expr "(" (expr (term 6) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (expr (term 8))) ")")))

(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
             (mspace expr mspace) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace term mspace) : (,save 'term $1 $2 $3)
             (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "  9 + (  6 + 8)  "

 '(expr (mspace SPACE (mspace SPACE (mspace))) (expr (term 9) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (expr "(" (expr (mspace SPACE (mspace SPACE (mspace))) (expr (term 6) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (expr (term 8))) (mspace)) ")")) (mspace SPACE (mspace SPACE (mspace)))))

(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
             (mspace expr mspace) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace term mspace) : (,save 'term $1 $2 $3)
             (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "  9 + (  6+ 8)  "

 '(expr (mspace SPACE (mspace SPACE (mspace))) (expr (term 9) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (expr "(" (expr (mspace SPACE (mspace SPACE (mspace))) (expr (term 6) (add (mspace) "+" (mspace SPACE (mspace))) (expr (term 8))) (mspace)) ")")) (mspace SPACE (mspace SPACE (mspace)))))

(test-parser-error
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
             (mspace expr mspace) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace term mspace) : (,save 'term $1 $2 $3)
             (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "  (9) + (  ( 1+ 6) + 8)  ")

(test-parser-error
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (mspace term mspace) : (,save 'term $1 $2 $3)
             (LPAREN term RPAREN) : (,save 'term $1 $2 $3)
             (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "9 + (6 + 8")

(test-parser
 `((exprs    (exprs expr) : (,save 'exprs $1 $2)
             (expr) : (,save 'exprs $1))
   (expr     (SPACE) : (,save 'expr $1)
             (ID) : (,save 'expr $1)))

 "foo bar"

 '(exprs (exprs (exprs (expr "foo")) (expr SPACE)) (expr "bar")))

(test-parser
 `((exprs    (exprs expr) : (,save 'exprs $1 $2)
             (expr) : (,save 'exprs $1))
   (expr     (SPACE) : (,save 'expr $1)
             (ID) : (,save 'expr $1)))

 "id1 id2"

 '(exprs (exprs (exprs (expr "id1")) (expr SPACE)) (expr "id2")))

(test-parser
 `((exprs    (exprs expr) : (,save 'exprs $1 $2)
             (expr) : (,save 'exprs $1))
   (expr     (SPACE) : (,save 'expr $1)
             (ID) : (,save 'expr $1)))

 "ida idb idc longerid"

 '(exprs (exprs (exprs (exprs (exprs (exprs (exprs (expr "ida")) (expr SPACE)) (expr "idb")) (expr SPACE)) (expr "idc")) (expr SPACE)) (expr "longerid")))


(test-parser
 `((lines    (line lines) : (,save 'lines $1 $2)
             (line)       : (,save 'lines $1)
             (exprs)      : (,save 'lines $1))
   (line     (exprs line) : (,save 'line $1 $2)
             (NEWLINE)    : (,save 'line $1))
   (exprs    (exprs expr) : (,save 'exprs $1 $2)
             (expr) : (,save 'exprs $1))
   (expr     (SPACE) : (,save 'expr $1)
             (ID) : (,save 'expr $1)))

 "a b c
d e f"

 '(lines (line (exprs (exprs (exprs (exprs (exprs (expr "a")) (expr SPACE)) (expr "b")) (expr SPACE)) (expr "c")) (line NEWLINE)) (lines (exprs (exprs (exprs (exprs (exprs (expr "d")) (expr SPACE)) (expr "e")) (expr SPACE)) (expr "f")))))

(test-parser
 `((lines    (line lines) : (,save 'lines $1 $2)
             (line)       : (,save 'lines $1)
             (exprs)      : (,save 'lines $1))
   (line     (exprs line) : (,save 'line $1 $2)
             (NEWLINE)    : (,save 'line $1))
   (exprs    (exprs expr) : (,save 'exprs $1 $2)
             (expr) : (,save 'exprs $1))
   (expr     (SPACE) : (,save 'expr $1)
             (ID) : (,save 'expr $1)))

 "idala idbla idcla longeridla
idblb idclb longeridlb"

 '(lines (line (exprs (exprs (exprs (exprs (exprs (exprs (exprs (expr "idala")) (expr SPACE)) (expr "idbla")) (expr SPACE)) (expr "idcla")) (expr SPACE)) (expr "longeridla")) (line NEWLINE)) (lines (exprs (exprs (exprs (exprs (exprs (expr "idblb")) (expr SPACE)) (expr "idclb")) (expr SPACE)) (expr "longeridlb")))))




(parameterize ((glr-parser?/p #t))
  (test-parser
   `((expr     (expr add term)
               (term))
     (add      (+))
     (term     (NUM)))

   "5+3"

   '((expr (expr (term 5)) (add "+") (term 3)))))



(test-parser
 `((expr     (expr add expr) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (+) : (,save 'add $1))
   (term     (NUM) : (,save 'term $1)))

 "5+3+4"

 '(expr (expr (term 5)) (add "+") (expr (expr (term 3)) (add "+") (expr (term 4)))))




(test-parser
 `((expr     (expr add expr) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (+) : (,save 'add $1))
   (term     (NUM) : (,save 'term $1)))

 "5+3+4+7"
 '(expr (expr (term 5)) (add "+") (expr (expr (term 3)) (add "+") (expr (expr (term 4)) (add "+") (expr (term 7))))))



(parameterize ((glr-parser?/p #t))
  (test-parser
   `((expr     (expr add expr) : (,save 'expr $1 $2 $3)
               (term) : (,save 'expr $1))
     (add      (+) : (,save 'add $1))
     (term     (NUM) : (,save 'term $1)))

   "5+3+4"

   '((expr (expr (expr (term 5)) (add "+") (expr (term 3))) (add "+") (expr (term 4))) (expr (expr (term 5)) (add "+") (expr (expr (term 3)) (add "+") (expr (term 4)))))))


(parameterize ((glr-parser?/p #t))
  (test-parser
   `((expr     (expr add expr) : (,save 'expr $1 $2 $3)
               (term) : (,save 'expr $1))
     (add      (+) : (,save 'add $1))
     (term     (NUM) : (,save 'term $1)))

   "5+3+4+7"

   '((expr (expr (expr (expr (term 5)) (add "+") (expr (term 3))) (add "+") (expr (term 4))) (add "+") (expr (term 7))) (expr (expr (expr (term 5)) (add "+") (expr (term 3))) (add "+") (expr (expr (term 4)) (add "+") (expr (term 7)))) (expr (expr (expr (term 5)) (add "+") (expr (expr (term 3)) (add "+") (expr (term 4)))) (add "+") (expr (term 7))) (expr (expr (term 5)) (add "+") (expr (expr (expr (term 3)) (add "+") (expr (term 4))) (add "+") (expr (term 7)))) (expr (expr (term 5)) (add "+") (expr (expr (term 3)) (add "+") (expr (expr (term 4)) (add "+") (expr (term 7))))))))


(parameterize ((glr-parser?/p #t))
  (test-parser
   `((funcall  (ID LPAREN args RPAREN) : (,save 'funcall $1 $2 $3 $4))
     (args     (args COMMA mspace arg) : (,save 'args $1 $2 $3)
               (arg) : (,save 'args $1))
     (arg      (ID) : (,save 'arg $1)
               (NUM) : (,save 'arg $1))
     (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
               () : (,save 'mspace)))

   "func(1,x ,y ,3)"

   '()))




(test-parser
 `((expr     (expr add term)
             (term))
   (add      (mspace + mspace))
   (term     (mspace NUM mspace))
   (mspace   (SPACE mspace) : (,save 'mspace-start $1 $2)
             () : (,save 'mspace-end)))

 "5+3"

 '(expr (expr (term (mspace-end) 5 (mspace-end))) (add (mspace-end) "+" (mspace-end)) (term (mspace-end) 3 (mspace-end))))



(parameterize ((glr-parser?/p #t))
  (test-parser
   `((expr     (expr add term)
               (term))
     (add      (mspace + mspace))
     (term     (mspace NUM mspace))
     (mspace   (SPACE mspace) : (,save 'mspace-start)
               () : (,save 'mspace-end)))

   "5+3"

   '((expr (expr (term (mspace-end) 5 (mspace-end))) (add (mspace-end) "+" (mspace-end)) (term (mspace-end) 3 (mspace-end))))))



(let ()
  (define parser
    (parselynn
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add term)
                  (term))
        (add      (+))
        (term     (NUM))))))

  (define result
    (with-string-as-input
     "5+3" (parselynn-run parser (make-lexer))))

  (assert= '(expr (expr (term 5)) (add "+") (term 3)) result))




(let ()
  (define parser
    (parselynn
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add term)
                  (term))
        (add      (+))
        (term     (NUM))))))

  (define errored? #f)
  (define (errorp type message-fmt token)
    (set! errored? #t)
    (assert= type 'end-of-input)
    'whatever-ignore-it)

  (define result
    (with-string-as-input
     "5+" (parselynn-run/with-error-handler
           parser errorp (make-lexer))))

  (assert errored?)
  (assert= #f result))




(let ()
  (define parser
    (parselynn
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add term)
                  (term))
        (add      (+))
        (term     (NUM))))))

  (define errored? #f)
  (define (errorp type message-fmt token)
    (unless errored?
      (assert= type 'unexpected-token))
    (set! errored? #t)
    'whatever-ignore-it)

  (define result
    (with-string-as-input
     "5+-" (parselynn-run/with-error-handler
            parser errorp (make-lexer))))

  (assert errored?)
  (assert= #f result))



(let ()
  (define parser
    (parselynn
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules:
        (expr     (expr add term)
                  (term))
        (add      (+))
        (term     (NUM))))))

  (for-each
   (lambda (n)
     (define input (stringf "5+~a" n))
     (define result
       (with-string-as-input
        input (parselynn-run parser (make-lexer))))

     (assert= `(expr (expr (term 5)) (add "+") (term ,n)) result))
   (iota 15)))


(let ()

  (for-each
   (lambda (n)
     (define parser
       (parselynn
        `((driver: glr)
          (results: all)
          (tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
          (rules:
           (expr     (expr add term)
                     (term))
           (add      (+))
           (term     (NUM))))))

     (define input (stringf "5+~a" n))
     (define result
       (with-string-as-input
        input
        (let ()
          (define iter
            (parselynn-run parser (make-lexer)))
          (collect-iterator iter))))

     (assert= `((expr (expr (term 5)) (add "+") (term ,n))) result))
   (iota 15)))

