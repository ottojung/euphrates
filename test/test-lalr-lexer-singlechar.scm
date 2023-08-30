
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

  (assert= (length output) (length expected-output))

  (for-each
   (lambda (got expected)
     (if (= 2 (vector-length expected))
         (begin
           (assert= (vector-ref got 0)
                    (vector-ref expected 0))
           (assert= (vector-ref got 1)
                    (vector-ref expected 1)))
         (assert= got expected)))

   output expected-output))

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

;; 13. All Characters Unrecognized
(test-error `((t_A . "A")) "BCD" 'unrecognized-character)

;; 14. Mix of Recognized and Unrecognized Characters
(test-error `((t_A . "A")) "ABC" 'unrecognized-character)

;; 15. First Character Unrecognized
(test-error `((t_A . "A")) "BAA" 'unrecognized-character)

;; 16. Last Character Unrecognized
(test-error `((t_A . "A")) "AAB" 'unrecognized-character)

;; 17. Middle Character Unrecognized
(test-error `((t_A . "A")) "ABA" 'unrecognized-character)


















(test1
 '((t_0 . "0")
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
   #(t_4 #\4 0 8 8 1)))




(test1
 '((t_0 . "0")
   (t_1 . "1")
   (t_2 . "2")
   (t_3 . "3")
   (t_4 . "4")
   (t_5 . "5")
   (t_6 . "6")
   (t_7 . "7")
   (t_8 . "8")
   (c_any class any))
 "19371634"
 '(#(t_1 #\1 0 1 1 1)
   #(c1_any #\9 0 2 2 1)
   #(t_3 #\3 0 3 3 1)
   #(t_7 #\7 0 4 4 1)
   #(t_1 #\1 0 5 5 1)
   #(t_6 #\6 0 6 6 1)
   #(t_3 #\3 0 7 7 1)
   #(t_4 #\4 0 8 8 1)))




(test1
 '((t_0 . "0")
   (t_1 . "1")
   (t_2 . "2")
   (t_3 . "3")
   (t_4 . "4")
   (t_5 . "5")
   (t_6 . "6")
   (t_7 . "7")
   (t_8 . "8")
   (t_other class any))
 "19371634"
 '(#(t_1 #\1 0 1 1 1)
   #(c_any #\9 0 2 2 1)
   #(t_3 #\3 0 3 3 1)
   #(t_7 #\7 0 4 4 1)
   #(t_1 #\1 0 5 5 1)
   #(t_6 #\6 0 6 6 1)
   #(t_3 #\3 0 7 7 1)
   #(t_4 #\4 0 8 8 1)))




(test1
 '((t_0 . "0")
   (t_1 . "1")
   (t_2 . "2")
   (t_3 . "3")
   (t_4 . "4")
   (t_5 . "5")
   (t_6 . "6")
   (t_7 . "7")
   (t_8 . "8")
   (t_num class numeric))
 "19371634"
 '(#(t_1 #\1 0 1 1 1)
   #(c_numeric #\9 0 2 2 1)
   #(t_3 #\3 0 3 3 1)
   #(t_7 #\7 0 4 4 1)
   #(t_1 #\1 0 5 5 1)
   #(t_6 #\6 0 6 6 1)
   #(t_3 #\3 0 7 7 1)
   #(t_4 #\4 0 8 8 1)))




(test1
 '((t_0 . "0")
   (t_1 . "1")
   (t_2 . "2")
   (t_3 . "3")
   (t_4 . "4")
   (t_5 . "5")
   (t_6 . "6")
   (t_7 . "7")
   (t_8 . "8")
   (t_? class alphabetic))
 "1x371634"
 '(#(t_1 #\1 0 1 1 1)
   #(c_alphabetic #\x 0 2 2 1)
   #(t_3 #\3 0 3 3 1)
   #(t_7 #\7 0 4 4 1)
   #(t_1 #\1 0 5 5 1)
   #(t_6 #\6 0 6 6 1)
   #(t_3 #\3 0 7 7 1)
   #(t_4 #\4 0 8 8 1)))




(test1
 '((t_0 . "0")
   (t_1 . "1")
   (t_2 . "2")
   (t_3 . "3")
   (t_4 . "4")
   (t_5 . "5")
   (t_6 . "6")
   (t_7 . "7")
   (t_8 . "8")
   (t_? class alphanum))
 "1x371634"
 '(#(t_1 #\1 0 1 1 1)
   #(c_alphanum #\x 0 2 2 1)
   #(t_3 #\3 0 3 3 1)
   #(t_7 #\7 0 4 4 1)
   #(t_1 #\1 0 5 5 1)
   #(t_6 #\6 0 6 6 1)
   #(t_3 #\3 0 7 7 1)
   #(t_4 #\4 0 8 8 1)))




(test1
 '((t_0 . "0")
   (t_1 . "1")
   (t_2 . "2")
   (t_3 . "3")
   (t_4 . "4")
   (t_5 . "5")
   (t_6 . "6")
   (t_7 . "7")
   (t_8 . "8")
   (t_x class alphanum)
   (t_a class alphabetic))
 "1x371634"
 '(#(t_1 #\1 0 1 1 1)
   #(c_alphabetic #\x 0 2 2 1)
   #(t_3 #\3 0 3 3 1)
   #(t_7 #\7 0 4 4 1)
   #(t_1 #\1 0 5 5 1)
   #(t_6 #\6 0 6 6 1)
   #(t_3 #\3 0 7 7 1)
   #(t_4 #\4 0 8 8 1)))




(test1
 '((t_0 . "0")
   (t_1 . "1")
   (t_2 . "2")
   (t_3 . "3")
   (t_4 . "4")
   (t_5 . "5")
   (t_6 . "6")
   (t_7 . "7")
   (t_8 . "8")
   (t_a class alphabetic)
   (t_x class alphanum))
 "1x371634"
 '(#(t_1 #\1 0 1 1 1)
   #(c_alphabetic #\x 0 2 2 1)
   #(t_3 #\3 0 3 3 1)
   #(t_7 #\7 0 4 4 1)
   #(t_1 #\1 0 5 5 1)
   #(t_6 #\6 0 6 6 1)
   #(t_3 #\3 0 7 7 1)
   #(t_4 #\4 0 8 8 1)))




(test1
 '((t_0 . "0")
   (t_1 . "1")
   (t_2 . "2")
   (t_3 . "3")
   (t_4 . "4")
   (t_5 . "5")
   (t_6 . "6")
   (t_7 . "7")
   (t_8 . "8")
   (t_a class alphabetic)
   (t_n class numeric)
   (t_x class alphanum))
 "1x371634"
 '(#(t_1 #\1 0 1 1 1)
   #(c_alphabetic #\x 0 2 2 1)
   #(t_3 #\3 0 3 3 1)
   #(t_7 #\7 0 4 4 1)
   #(t_1 #\1 0 5 5 1)
   #(t_6 #\6 0 6 6 1)
   #(t_3 #\3 0 7 7 1)
   #(t_4 #\4 0 8 8 1)))




(test1
 '((t_0 . "0")
   (t_1 . "1")
   (t_2 . "2")
   (t_3 . "3")
   (t_4 . "4")
   (t_5 . "5")
   (t_6 . "6")
   (t_7 . "7")
   (t_8 . "8")
   (t_x . "x3")
   (t_a class alphabetic)
   (t_n class numeric)
   (t_x class alphanum))
 "1x371634"
 '(#(t_1 #\1 0 1 1 1)
   #(c_x #\x 0 2 2 1)
   #(t_3 #\3 0 3 3 1)
   #(t_7 #\7 0 4 4 1)
   #(t_1 #\1 0 5 5 1)
   #(t_6 #\6 0 6 6 1)
   #(t_3 #\3 0 7 7 1)
   #(t_4 #\4 0 8 8 1)))




(test1
 '((t_0 . "0")
   (t_1 . "1")
   (t_2 . "2")
   (t_3 . "3")
   (t_4 . "4")
   (t_5 . "5")
   (t_6 . "6")
   (t_7 . "7")
   (t_8 . "8")
   (c_x . "x3")
   (t_a class alphabetic)
   (t_n class numeric)
   (t_x class alphanum))
 "1x371634"
 '(#(t_1 #\1 0 1 1 1)
   #(c1_x #\x 0 2 2 1)
   #(t_3 #\3 0 3 3 1)
   #(t_7 #\7 0 4 4 1)
   #(t_1 #\1 0 5 5 1)
   #(t_6 #\6 0 6 6 1)
   #(t_3 #\3 0 7 7 1)
   #(t_4 #\4 0 8 8 1)))




(test1
 '((t_0 . "0")
   (t_1 . "1")
   (t_2 . "2")
   (t_3 . "3")
   (t_4 . "4")
   (t_5 . "5")
   (t_6 . "6")
   (t_7 . "7")
   (t_8 . "8")
   (t_12 . "12")
   (t_num class numeric))
 "1123412"
 '(#(t_1 #\1 0 1 1 1)
   #(t_1 #\1 0 2 2 1)
   #(t_2 #\2 0 3 3 1)
   #(t_3 #\3 0 4 4 1)
   #(t_4 #\4 0 5 5 1)
   #(t_1 #\1 0 6 6 1)
   #(t_2 #\2 0 7 7 1)))




(test1
 '((t_1 . "1")) "" '())




(test1
 '((t_A . "A") (t_B . "B"))
 "AB"
 '(#(t_A #\A 0 1 1 1) #(t_B #\B 0 2 2 1)))




(test1
 '((t_AB . "AB"))
 "AB"
 '(#(c_A #\A 0 1 1 1) #(c_B #\B 0 2 2 1)))




(test1
 '((t_num class numeric))
 "123"
 '(#(c_numeric #\1 0 1 1 1)
   #(c_numeric #\2 0 2 2 1)
   #(c_numeric #\3 0 3 3 1)))




(test1
 '((t_A . "A") (t_num class numeric))
 "A1"
 '(#(t_A #\A 0 1 1 1) #(c_numeric #\1 0 2 2 1)))




(test1
 '((t_AB . "AB") (t_num class numeric))
 "AB1"
 '(#(c_A #\A 0 1 1 1)
   #(c_B #\B 0 2 2 1)
   #(c_numeric #\1 0 3 3 1)))




(test1
 '((t_A . "A") (t_AB . "AB") (t_num class numeric))
 "AAB1"
 '(#(t_A #\A 0 1 1 1)
   #(t_A #\A 0 2 2 1)
   #(c_B #\B 0 3 3 1)
   #(c_numeric #\1 0 4 4 1)))




(test1
 '((t_A . "A"))
 "AAA"
 '(#(t_A #\A 0 1 1 1)
   #(t_A #\A 0 2 2 1)
   #(t_A #\A 0 3 3 1)))




(test1
 '((t_AB . "AB"))
 "ABAB"
 '(#(c_A #\A 0 1 1 1)
   #(c_B #\B 0 2 2 1)
   #(c_A #\A 0 3 3 1)
   #(c_B #\B 0 4 4 1)))




(test1
 '((t_num class numeric) (t_any class any))
 "A1"
 '(#(c_any #\A 0 1 1 1) #(c_numeric #\1 0 2 2 1)))




(test1
 '((t_AB1 . "AB1") (t_num class numeric))
 "AB1"
 '(#(c_A #\A 0 1 1 1)
   #(c_B #\B 0 2 2 1)
   #(c_1 #\1 0 3 3 1)))




(test1
 '((t_A . "A") (t_any class any))
 "A"
 '(#(t_A #\A 0 1 1 1)))




(test1
 '((t_num class numeric))
 "123"
 '(#(c_numeric #\1 0 1 1 1)
   #(c_numeric #\2 0 2 2 1)
   #(c_numeric #\3 0 3 3 1)))




(test1
 '((t_alpha class alphabetic))
 "ABC"
 '(#(c_alphabetic #\A 0 1 1 1)
   #(c_alphabetic #\B 0 2 2 1)
   #(c_alphabetic #\C 0 3 3 1)))




(test1
 '((t_alnum class alphanum))
 "A1"
 '(#(c_alphanum #\A 0 1 1 1)
   #(c_alphanum #\1 0 2 2 1)))




