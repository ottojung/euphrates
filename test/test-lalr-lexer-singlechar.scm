
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


(define (test/generic tokens-alist input expected-output)
  (define taken
    (make-hashset))

  (define lexer-factory
    (make-lalr-lexer/singlechar-factory taken tokens-alist))

  (define lexer
    (lexer-factory input))

  (define output
    (collect lexer))

  (assert= expected-output output))

(define (test/string tokens-alist input expected-output)
  (test/generic tokens-alist input expected-output))

(define (test/port tokens-alist input expected-output)
  (with-string-as-input
   input
   (test/generic tokens-alist (current-input-port) expected-output)))

(define (test1 tokens-alist input expected-output)
  (test/string tokens-alist input expected-output)
  (test/port tokens-alist input expected-output))

(define (test-error tokens-alist input expected-error-type)
  (assert-throw
   expected-error-type
   (test/string tokens-alist input '()))

  (assert-throw
   expected-error-type
   (test/port tokens-alist input '())))


;;;;;;;;;
;;
;; Start...
;;



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




(test-error

 `((t_0 . "0")
   (t_1 . "1")
   (t_2 . "2")
   (t_3 . "3")
   (t_4 . "4")
   (t_5 . "5")
   (t_6 . "6")
   (t_7 . "7")
   (t_8 . "8"))

 "19371634"

 'unrecognized-character

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
   (t_8 . "8")
   (t_any . (class any)))

 "19371634"

 '(#(t_1 #\1 0 1 1 1)
   #(t_any #\9 0 2 2 1)
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
   (t_8 . "8")
   (t_other . (class any)))

 "19371634"

 '(#(t_1 #\1 0 1 1 1)
   #(t_any #\9 0 2 2 1)
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
   (t_8 . "8")
   (t_num . (class numeric)))

 "19371634"

 '(#(t_1 #\1 0 1 1 1)
   #(t_numeric #\9 0 2 2 1)
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
   (t_8 . "8")
   (t_? . (class alphanum)))

 "1x371634"

 '(#(t_1 #\1 0 1 1 1)
   #(t_alphanum #\x 0 2 2 1)
   #(t_3 #\3 0 3 3 1)
   #(t_7 #\7 0 4 4 1)
   #(t_1 #\1 0 5 5 1)
   #(t_6 #\6 0 6 6 1)
   #(t_3 #\3 0 7 7 1)
   #(t_4 #\4 0 8 8 1))

 )




(test-error

 `((t_0 . "0")
   (t_1 . "1")
   (t_2 . "2")
   (t_3 . "3")
   (t_a . (class any))
   (t_4 . "4")
   (t_5 . "5")
   (t_6 . "6")
   (t_7 . "7")
   (t_8 . "8")
   (t_b . (class any)))

 "19371634"

 'duplicated-token

 )




