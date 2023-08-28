
(define (collect lexer)
  (let loop ()
    (define t (lexer))
    (if (equal? '*eoi* t) '()
        (let ((loc (lexical-token-source t)))
          (cons (vector (lexical-token-category t)
                        (lexical-token-value t)
                        (source-location-line loc)
                        (source-location-column loc)
                        (source-location-offset loc)
                        (source-location-length loc))
                (loop))))))


(define (test/generic tokens-alist default-token input expected-output)
  (define lexer-factory
    (make-lalr-lexer/singlechar-factory tokens-alist default-token))

  (define lexer
    (lexer-factory input))

  (define output
    (collect lexer))

  (assert= expected-output output))

(define (test/string tokens-alist default-token input expected-output)
  (test/generic tokens-alist default-token input expected-output))

(define (test/port tokens-alist default-token input expected-output)
  (with-string-as-input
   input
   (test/generic tokens-alist default-token (current-input-port) expected-output)))

(define (test1 tokens-alist default-token input expected-output)
  (test/string tokens-alist default-token input expected-output)
  (test/port tokens-alist default-token input expected-output))


(test1

 `((t_0 . "0")
   (t_1 . "1")
   (t_2 . "2")
   (t_3 . "3")
   (t_4 . "4")
   (t_5 . "5")
   (t_6 . "6")
   (t_7 . "7")
   (t_8 . "8")
   (t_9 . "9"))

 't_other

 "19371634"


 '(#(t_1 #\1 0 1 1 1)
   #(t_9 #\9 0 2 2 1)
   #(t_3 #\3 0 3 3 1)
   #(t_7 #\7 0 4 4 1)
   #(t_1 #\1 0 5 5 1)
   #(t_6 #\6 0 6 6 1)
   #(t_3 #\3 0 7 7 1)
   #(t_4 #\4 0 8 8 1))

 )




(test1

 `((t_0 . "0")
   (t_1 . "1")
   (t_2 . "2")
   (t_3 . "3")
   (t_4 . "4")
   (t_5 . "5")
   (t_6 . "6")
   (t_7 . "7")
   (t_8 . "8"))

 't_other

 "19371634"


 '(#(t_1 #\1 0 1 1 1)
   #(t_other #\9 0 2 2 1)
   #(t_3 #\3 0 3 3 1)
   #(t_7 #\7 0 4 4 1)
   #(t_1 #\1 0 5 5 1)
   #(t_6 #\6 0 6 6 1)
   #(t_3 #\3 0 7 7 1)
   #(t_4 #\4 0 8 8 1))

 )




