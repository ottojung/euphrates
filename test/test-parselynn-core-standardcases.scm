
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
                ((char=? c #\newline) (parselynn:token:make 'NEWLINE location 'NEWLINE))
                ((char-whitespace? c) (parselynn:token:make 'SPACE   location 'SPACE))
                ((char=? c #\+)       (parselynn:token:make '+       location (string c)))
                ((char=? c #\-)       (parselynn:token:make '-       location (string c)))
                ((char=? c #\*)       (parselynn:token:make '*       location (string c)))
                ((char=? c #\/)       (parselynn:token:make '/       location (string c)))
                ((char=? c #\=)       (parselynn:token:make '=       location (string c)))
                ((char=? c #\,)       (parselynn:token:make 'COMMA   location (string c)))
                ((char=? c #\()       (parselynn:token:make 'LPAREN  location (string c)))
                ((char=? c #\))       (parselynn:token:make 'RPAREN  location (string c)))
                ((char-numeric? c)    (parselynn:token:make 'NUM     location (read-number (list c))))
                ((char-alphabetic? c) (parselynn:token:make 'ID      location (read-id (list c))))
                (else
                 (raisu
                  'lex-error
                  (stringf "PARSE ERROR : illegal character: ~s" c)
                  c)
                 (loop))))))))

(define glr-parser?/p
  (make-parameter #f))

(define (make-test-parser parser-rules)
  (define (build)
    (parselynn:core
     `((driver: ,(if (glr-parser?/p) 'glr '(LR 1))) ;; FIXME: DEBUG, change to 'lr.
       ;; `((driver: ,(if (glr-parser?/p) 'glr 'lr))
       (results: ,(if (glr-parser?/p) 'all 'first))
       (tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (rules: ,@parser-rules))))

  (if (glr-parser?/p)
      (parameterize ((parselynn:core:conflict-handler/p ignore))
        (build))
      (build)))

(define (also-test-respective-glr parser-rules input expected-output)
  (define conflicting-glr? #f)
  (define parser/glr/first
    (parameterize ((parselynn:core:conflict-handler/p
                    (lambda _ (set! conflicting-glr? #t))))
      (parselynn:core
       `((driver: glr)
         (results: first)
         (tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
         (rules: ,@parser-rules)))))

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

  (unless (equal? expected-output result)
    (debug "\n\nactual:\n~s\n" result))

  (assert= expected-output result)

  (unless (glr-parser?/p)
    (also-test-respective-glr parser-rules input expected-output)))


(define-syntax test-parser-error
  (syntax-rules ()
    ((_ parser-rules input)
     (let ()
       (define parser
         (make-test-parser parser-rules))

       (assert-throw
        'parse-error
        (run-input parser input))))))

(define-syntax run-input
  (syntax-rules ()
    ((_ parser input)
     (let ()
       (define parser* parser)
       (with-string-as-input
        input

        (if (glr-parser?/p)
            (let ()
              (define iter (parselynn-run parser* (make-lexer)))
              (collect-iterator iter))
            (parselynn-run parser* (make-lexer))))))))

(define save list)

;;;;;;;;;;;;;;;;
;; TEST CASES ;;
;;;;;;;;;;;;;;;;

(test-parser
 `((expr     (expr add term)
             (term))
   (add      (mspace + mspace))
   (term     (NUM))
   (mspace   (SPACE mspace)
             ()))

 "5+3"

 `(expr (expr (term 5)) (add (mspace) "+" (mspace)) (term 3)))

(test-parser
 `((expr     (expr add term)
             (term))
   (add      (mspace + mspace))
   (term     (NUM))
   (mspace   (SPACE mspace)
             ()))

 "5   +   3"

 `(expr (expr (term 5)) (add (mspace SPACE (mspace SPACE (mspace SPACE (mspace)))) "+" (mspace SPACE (mspace SPACE (mspace SPACE (mspace))))) (term 3)))

(test-parser
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "5+3"

 `(expr (expr (term 5)) (add (mspace) "+" (mspace)) (term 3)))

(test-parser
 `((expr     (expr add term) : (+ $1 $3)
             (term) : (+ $1))
   (add      (mspace + mspace) : (+ 0))
   (term     (NUM) : (+ $1))
   (mspace   (SPACE mspace) : (+ 0)
             () : (+ 0)))

 "5+3"

 8)

(test-parser
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "5 + 3"

 `(expr (expr (term 5)) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (term 3)))

(test-parser
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "54 + 382176"

 `(expr (expr (term 54)) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (term 382176)))

(test-parser
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "5 + 3 + 4 + 7"

 `(expr (expr (expr (expr (term 5)) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (term 3)) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (term 4)) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (term 7)))

(test-parser
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "5"

 `(expr (term 5)))

(test-parser-error
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "5 +")

(test-parser-error
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "  5   + 3  ")

(test-parser-error
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "5+4+")

(test-parser-error
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (NUM) : (,save 'term $1))
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
   (term     (LPAREN term RPAREN) : (,save 'term $1 $2 $3)
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
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "9 + (6 + 8)"

 '(expr (term 9) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (expr "(" (expr (term 6) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (expr (term 8))) ")")))

(test-parser-error
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "  9 + (  6 + 8)  ")

(assert-throw
 'parse-conflict
 (test-parser
  `((expr     (term add expr) : (,save 'expr $1 $2 $3)
              (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
              (mspace expr mspace) : (,save 'expr $1 $2 $3)
              (term) : (,save 'expr $1))
    (add      (mspace + mspace) : (,save 'add $1 $2 $3))
    (term     (term) : (,save 'term $1)
              (NUM) : (,save 'term $1))
    (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
              () : (,save 'mspace)))

  "  9 + (  6+ 8)  "

 '()))

(test-parser-error
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "(9) + ((1+ 6) + 8)")

(test-parser-error
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "9 + ((1 + 6) + 8)")

(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (LPAREN expr RPAREN) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (NUM) : (,save 'term $1))
   (mspace   (SPACE mspace) : (,save 'mspace $1 $2)
             () : (,save 'mspace)))

 "9 + (8 + (1 + 6))"

 `(expr (term 9) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (expr "(" (expr (term 8) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (expr "(" (expr (term 1) (add (mspace SPACE (mspace)) "+" (mspace SPACE (mspace))) (expr (term 6))) ")")) ")")))

(test-parser-error
 `((expr     (expr add term) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (mspace + mspace) : (,save 'add $1 $2 $3))
   (term     (LPAREN term RPAREN) : (,save 'term $1 $2 $3)
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
 `((lines    (line)       : (,save 'lines $1)
             (line lines) : (,save 'lines $1 $2))
   (line     (exprs NEWLINE) : (,save 'line $1 $2))
   (exprs    (expr)       : (,save 'exprs $1)
             (exprs expr) : (,save 'exprs $1 $2))
   (expr     (SPACE) : (,save 'expr $1)
             (ID) : (,save 'expr $1)))

 "a b c
d e f
"

 `(lines (line (exprs (exprs (exprs (exprs (exprs (expr "a")) (expr SPACE)) (expr "b")) (expr SPACE)) (expr "c")) NEWLINE) (lines (line (exprs (exprs (exprs (exprs (exprs (expr "d")) (expr SPACE)) (expr "e")) (expr SPACE)) (expr "f")) NEWLINE))))

(test-parser
 `((lines    (line)       : (,save 'lines $1)
             (line lines) : (,save 'lines $1 $2))
   (line     (exprs NEWLINE) : (,save 'line $1 $2))
   (exprs    (expr)       : (,save 'exprs $1)
             (exprs expr) : (,save 'exprs $1 $2))
   (expr     (SPACE) : (,save 'expr $1)
             (ID) : (,save 'expr $1)))

 "idala idbla idcla longeridla
idblb idclb longeridlb
"

 `(lines (line (exprs (exprs (exprs (exprs (exprs (exprs (exprs (expr "idala")) (expr SPACE)) (expr "idbla")) (expr SPACE)) (expr "idcla")) (expr SPACE)) (expr "longeridla")) NEWLINE) (lines (line (exprs (exprs (exprs (exprs (exprs (expr "idblb")) (expr SPACE)) (expr "idclb")) (expr SPACE)) (expr "longeridlb")) NEWLINE))))


(parameterize ((glr-parser?/p #t))
  (test-parser
   `((expr     (expr add term)
               (term))
     (add      (+))
     (term     (NUM)))

   "5+3"

   '((expr (expr (term 5)) (add "+") (term 3)))))



(assert-throw
 'parse-conflict
 (test-parser
  `((expr     (expr add expr) : (,save 'expr $1 $2 $3)
              (term) : (,save 'expr $1))
    (add      (+) : (,save 'add $1))
    (term     (NUM) : (,save 'term $1)))

  "5+3+4"

  '(expr (expr (term 5)) (add "+") (expr (expr (term 3)) (add "+") (expr (term 4))))))



(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (+) : (,save 'add $1))
   (term     (NUM) : (,save 'term $1)))

 "5+3+4"

 `(expr (term 5) (add "+") (expr (term 3) (add "+") (expr (term 4)))))




(test-parser
 `((expr     (term add expr) : (,save 'expr $1 $2 $3)
             (term) : (,save 'expr $1))
   (add      (+) : (,save 'add $1))
   (term     (NUM) : (,save 'term $1)))

 "5+3+4+7"
 `(expr (term 5) (add "+") (expr (term 3) (add "+") (expr (term 4) (add "+") (expr (term 7))))))



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
   (term     (NUM))
   (mspace   (SPACE mspace) : (,save 'mspace-start $1 $2)
             () : (,save 'mspace-end)))

 "5+3"

 `(expr (expr (term 5)) (add (mspace-end) "+" (mspace-end)) (term 3)))



(parameterize ((glr-parser?/p #t))
  (test-parser
   `((expr     (expr add term)
               (term))
     (add      (mspace + mspace))
     (term     (NUM))
     (mspace   (SPACE mspace) : (,save 'mspace-start)
               () : (,save 'mspace-end)))

   "5+3"

   `((expr (expr (term 5)) (add (mspace-end) "+" (mspace-end)) (term 3)))))



(let ()
  (define parser
    (parselynn:core
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (driver: (LR 1))
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
    (parselynn:core
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (driver: (LR 1))
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
    (parselynn:core
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (driver: (LR 1))
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
    (parselynn:core
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (driver: (LR 1))
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
       (parselynn:core
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




(let ()
  ;; Test double list separated.

  (define parser
    (parselynn:core
     `((tokens: NUM / SPACE)
       (driver: (LR 1))
       (rules:
        (start    (left split right))
        (left     (term) (term sep left))
        (right    (term) (term sep left))
        (split    (/))
        (sep      (SPACE))
        (term     (NUM))))))

  (define result
    (with-string-as-input
     "5 3/4 6"
     (parselynn-run parser (make-lexer))))

  (assert=
   '(start (left (term 5) (sep SPACE) (left (term 3))) (split "/") (right (term 4) (sep SPACE) (left (term 6))))
   result))

(let ()
  ;; Test double list separated [2].

  (assert-throw
   'parse-conflict

    (parselynn:core
     `((tokens: NUM / SPACE)
       (driver: lr)
       (rules:
        (start    (left SPACE / SPACE right))
        (left     (NUM) (NUM SPACE left))
        (right    (NUM) (NUM SPACE left)))))))

(let ()
  ;; Test double list separated [2].

  (assert-throw
   'parse-conflict

    (parselynn:core
     `((tokens: NUM / SPACE)
       (driver: (LR 1))
       (rules:
        (start    (left SPACE / SPACE right))
        (left     (NUM) (NUM SPACE left))
        (right    (NUM) (NUM SPACE left)))))))

(let ()
  ;; Test double list separated [3].

  (assert-throw
   'parse-conflict

    (parselynn:core
     `((tokens: NUM / SPACE)
       (driver: (LR 1))
       (rules:
        (start    (left sep split sep right))
        (left     (term) (term sep left))
        (right    (term) (term sep left))
        (sep      (SPACE))
        (split    (/))
        (term     (NUM)))))))


(let ()
  ;; Test epsilon production [1].

  (define parser
    (parselynn:core
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (driver: (LR 1))
       (rules:
        (start    (term cont))
        (cont     (comma term cont) ())
        (comma    (+))
        (term     (NUM))))))

  (define result
    (with-string-as-input
     "5+3+4+6"
     (parselynn-run parser (make-lexer))))

  (assert=
   '(start (term 5) (cont (comma "+") (term 3) (cont (comma "+") (term 4) (cont (comma "+") (term 6) (cont)))))
   result))




(let ()
  ;; Test epsilon production [2].

  (define parser
    (parselynn:core
     `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
       (driver: (LR 1))
       (rules:
        (start    (term cont))
        (cont     (comma term cont) ())
        (comma    (+))
        (term     (NUM))))))

  (define result
    (with-string-as-input
     "5+3+4+6"
     (parselynn-run parser (make-lexer))))

  (assert=
   '(start (term 5) (cont (comma "+") (term 3) (cont (comma "+") (term 4) (cont (comma "+") (term 6) (cont)))))
   result))


(let ()
  ;; Test large grammar.

  (define (make-arith-lexer for-how-long repeating-terms)
    (define (make-token x)
      (parselynn:token:make x 0 x))
    (define repeating-tokens
      (map make-token repeating-terms))
    (define operators
      `(+ * - ^ %))
    (define operator-tokens
      (list->vector (map make-token operators)))
    (define buf repeating-tokens)
    (define i 1)

    (define (next)
      (cond
       ((null? buf)
        (set! buf repeating-tokens)
        (next))

       ((and (> i for-how-long)
             (= 0 (modulo i 2)))

        parselynn:end-of-input)

       ((= 0 (modulo i 2))
        (set! i (+ 1 i))
        (vector-ref operator-tokens (modulo i 5)))

       (else
        (let ((t (car buf)))
          (set! i (+ 1 i))
          (set! buf (cdr buf))
          t))))

    (when (null? repeating-tokens)
      (raisu 'bad-repeating-tokens repeating-tokens))

    (lambda () (next)))

  (define numbers
    `(n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13 n14 n15 n16 n17 n18 n19 n20 n21 n22 n23 n24 n25 n26 n27 n28 n29 n30 n31 n32 n33 n34 n35 n36 n37 n38 n39 n40 n41 n42 n43 n44 n45 n46 n47 n48 n49 n50 n51 n52 n53 n54 n55 n56 n57 n58 n59 n60 n61 n62 n63 n64 n65 n66 n67 n68 n69 n70 n71 n72 n73 n74 n75 n76 n77 n78 n79 n80 n81 n82 n83 n84 n85 n86 n87 n88 n89 n90 n91 n92 n93 n94 n95 n96 n97 n98 n99 n100 n101 n102 n103 n104 n105 n106 n107 n108 n109 n110 n111 n112 n113 n114 n115 n116 n117 n118 n119 n120 n121 n122 n123 n124 n125 n126 n127 n128 n129 n130 n131 n132 n133 n134 n135 n136 n137 n138 n139 n140 n141 n142 n143 n144 n145 n146 n147 n148 n149 n150 n151 n152 n153 n154 n155 n156 n157 n158 n159 n160 n161 n162 n163 n164 n165 n166 n167 n168 n169 n170 n171 n172 n173 n174 n175 n176 n177 n178 n179 n180 n181 n182 n183 n184 n185 n186 n187 n188 n189 n190 n191 n192 n193 n194 n195 n196 n197 n198 n199 n200 n201 n202 n203 n204 n205 n206 n207 n208 n209 n210 n211 n212 n213 n214 n215 n216 n217 n218 n219 n220 n221 n222 n223 n224 n225 n226 n227 n228 n229 n230 n231 n232 n233 n234 n235 n236 n237 n238 n239 n240 n241 n242 n243 n244 n245 n246 n247 n248 n249 n250 n251 n252 n253 n254 n255 n256 n257 n258 n259 n260 n261 n262 n263 n264 n265 n266 n267 n268 n269 n270 n271 n272 n273 n274 n275 n276 n277 n278 n279 n280 n281 n282 n283 n284 n285 n286 n287 n288 n289 n290 n291 n292 n293 n294 n295 n296 n297 n298 n299 n300))

  (define parser
    (parselynn:core
     `((tokens: + * - ^ % ,@numbers)
       (driver: (LR 1))
       (rules:
        (expr    (term op expr) (term))
        (op      (+) (*) (-) (^) (%))
        (term    ,@(map list numbers))))))

  (define lexer
    (make-arith-lexer 2000 numbers))

  (define result
    (parselynn-run parser lexer))

  (assert (pair? result))

  )
