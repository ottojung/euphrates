
;;
;;
;;  ▄▄▄▄▄▄▄                 ▄                           ▄
;;     █     ▄▄▄    ▄▄▄   ▄▄█▄▄          ▄▄▄    ▄▄▄   ▄▄█▄▄  ▄   ▄  ▄▄▄▄
;;     █    █▀  █  █   ▀    █           █   ▀  █▀  █    █    █   █  █▀ ▀█
;;     █    █▀▀▀▀   ▀▀▀▄    █            ▀▀▀▄  █▀▀▀▀    █    █   █  █   █
;;     █    ▀█▄▄▀  ▀▄▄▄▀    ▀▄▄         ▀▄▄▄▀  ▀█▄▄▀    ▀▄▄  ▀▄▄▀█  ██▄█▀
;;                                                                  █
;;                                                                  ▀

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


(define (test/generic tokens-alist input expected-output expected-additional-rules)
  (define taken
    (make-hashset))

  (define lexer
    (make-parselynn/singlechar taken tokens-alist))

  (define additional-grammar-rules
    (parselynn/singlechar:additional-grammar-rules lexer))

  (debugs additional-grammar-rules)

  ;; NOTE: this is too specific to test. Let the parser test generated grammar.
  (when expected-additional-rules
    (assert= expected-additional-rules additional-grammar-rules))

  (define lexer-result
    (cond
     ((string? input)
      (parselynn/singlechar:run-on-string lexer input))
     ((port? input)
      (parselynn/singlechar:run-on-char-port lexer input))
     (else
      (raisu 'bad-input-type input))))

  (define lexer-iterator
    (parselynn/singlechar-result:as-iterator lexer-result))

  (define output
    (collect lexer-iterator))

  (debugs output)

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

(define (test/string tokens-alist input expected-output expected-additional-rules)
  (test/generic tokens-alist input expected-output expected-additional-rules))

(define (test/port tokens-alist input expected-output expected-additional-rules)
  (with-string-as-input
   input
   (test/generic tokens-alist (current-input-port) expected-output expected-additional-rules)))

(define (testcase tokens-alist input expected-output expected-additional-rules)
  ;; (test/string tokens-alist input expected-output expected-additional-rules)
  (test/port tokens-alist input expected-output expected-additional-rules))

(define (test-error tokens-alist input expected-error-type)
  (define additional-grammar-rules #f)

  (assert-throw
   expected-error-type
   (test/string tokens-alist input '() additional-grammar-rules))

  (assert-throw
   expected-error-type
   (test/port tokens-alist input '() additional-grammar-rules)))




;; ;;
;; ;;
;; ;;  ▄▄▄▄▄▄▄                 ▄
;; ;;     █     ▄▄▄    ▄▄▄   ▄▄█▄▄          ▄▄▄    ▄▄▄    ▄▄▄    ▄▄▄    ▄▄▄
;; ;;     █    █▀  █  █   ▀    █           █▀  ▀  ▀   █  █   ▀  █▀  █  █   ▀
;; ;;     █    █▀▀▀▀   ▀▀▀▄    █           █      ▄▀▀▀█   ▀▀▀▄  █▀▀▀▀   ▀▀▀▄
;; ;;     █    ▀█▄▄▀  ▀▄▄▄▀    ▀▄▄         ▀█▄▄▀  ▀▄▄▀█  ▀▄▄▄▀  ▀█▄▄▀  ▀▄▄▄▀
;; ;;
;; ;;



;; (testcase

;;  '((t_0 . #\0)
;;    (t_1 . #\1)
;;    )

;;  "0101011101"

;;  '(#(t_0 #\0 0 1 1 1)
;;    #(t_1 #\1 0 2 2 1)
;;    #(t_0 #\0 0 3 3 1)
;;    #(t_1 #\1 0 4 4 1)
;;    #(t_0 #\0 0 5 5 1)
;;    #(t_1 #\1 0 6 6 1)
;;    #(t_1 #\1 0 7 7 1)
;;    #(t_1 #\1 0 8 8 1)
;;    #(t_0 #\0 0 9 9 1)
;;    #(t_1 #\1 0 10 10 1)
;;    )


;;  '()
;;  )



;; (testcase

;;  '((t_0 . #\0)
;;    (t_1 . #\1)
;;    (t_2 . #\2)
;;    (t_3 . #\3)
;;    (t_4 . #\4)
;;    (t_5 . #\5)
;;    (t_6 . #\6)
;;    (t_7 . #\7)
;;    (t_8 . #\8)
;;    (t_9 . #\9)
;;    )

;;  "19371634"

;;  '(#(t_1 #\1 0 1 1 1)
;;    #(t_9 #\9 0 2 2 1)
;;    #(t_3 #\3 0 3 3 1)
;;    #(t_7 #\7 0 4 4 1)
;;    #(t_1 #\1 0 5 5 1)
;;    #(t_6 #\6 0 6 6 1)
;;    #(t_3 #\3 0 7 7 1)
;;    #(t_4 #\4 0 8 8 1))

;;  '()
;;  )



;; (testcase

;;  '((t_0 . "0")
;;    (t_1 . "1")
;;    (t_2 . "2")
;;    (t_3 . "3")
;;    (t_4 . "4")
;;    (t_5 . "5")
;;    (t_6 . "6")
;;    (t_7 . "7")
;;    (t_8 . "8")
;;    (c_any . (class any))
;;    )

;;  "19371634"

;;  '(#(t_1 #\1 0 1 1 1)
;;    #(uid_1 #\9 0 2 2 1)
;;    #(t_3 #\3 0 3 3 1)
;;    #(t_7 #\7 0 4 4 1)
;;    #(t_1 #\1 0 5 5 1)
;;    #(t_6 #\6 0 6 6 1)
;;    #(t_3 #\3 0 7 7 1)
;;    #(t_4 #\4 0 8 8 1))

;;  '((c_any (t_0)
;;           (t_1)
;;           (t_2)
;;           (t_3)
;;           (t_4)
;;           (t_5)
;;           (t_6)
;;           (t_7)
;;           (t_8)
;;           (uid_1)
;;           (uid_2)
;;           (uid_3)
;;           (uid_4)
;;           (uid_5)
;;           (uid_6)))

;;  )




;; (testcase

;;  '((c_any . (class any))
;;    )

;;  "19371634"

;;  '(#(uid_1 #\1 0 1 1 1)
;;    #(uid_1 #\9 0 2 2 1)
;;    #(uid_1 #\3 0 3 3 1)
;;    #(uid_1 #\7 0 4 4 1)
;;    #(uid_1 #\1 0 5 5 1)
;;    #(uid_1 #\6 0 6 6 1)
;;    #(uid_1 #\3 0 7 7 1)
;;    #(uid_1 #\4 0 8 8 1))

;;  '((c_any (uid_1)
;;           (uid_2)
;;           (uid_3)
;;           (uid_4)
;;           (uid_5)
;;           (uid_6)))

;;  )



;; (testcase

;;  '((t_0 . "0")
;;    (t_1 . "1")
;;    (t_2 . "2")
;;    (t_3 . "3")
;;    (t_4 . "4")
;;    (t_5 . "5")
;;    (t_6 . "6")
;;    (t_7 . "7")
;;    (t_8 . "8")
;;    (t_other . (class any)))

;;  "19371634"

;;  '(#(t_1 #\1 0 1 1 1)
;;    #(uid_1 #\9 0 2 2 1)
;;    #(t_3 #\3 0 3 3 1)
;;    #(t_7 #\7 0 4 4 1)
;;    #(t_1 #\1 0 5 5 1)
;;    #(t_6 #\6 0 6 6 1)
;;    #(t_3 #\3 0 7 7 1)
;;    #(t_4 #\4 0 8 8 1))

;;  '((t_other
;;    (t_0)
;;    (t_1)
;;    (t_2)
;;    (t_3)
;;    (t_4)
;;    (t_5)
;;    (t_6)
;;    (t_7)
;;    (t_8)
;;    (uid_1)
;;    (uid_2)
;;    (uid_3)
;;    (uid_4)
;;    (uid_5)
;;    (uid_6)))

;;  )



;; (testcase

;;  '((t_0 . "0")
;;    (t_1 . "1")
;;    (t_2 . "2")
;;    (t_3 . "3")
;;    (t_4 . "4")
;;    (t_5 . "5")
;;    (t_6 . "6")
;;    (t_7 . "7")
;;    (t_8 . "8")
;;    (t_num . (class numeric)))

;;  "19371634"

;;  '(#(t_1 #\1 0 1 1 1)
;;    #(uid_1 #\9 0 2 2 1)
;;    #(t_3 #\3 0 3 3 1)
;;    #(t_7 #\7 0 4 4 1)
;;    #(t_1 #\1 0 5 5 1)
;;    #(t_6 #\6 0 6 6 1)
;;    #(t_3 #\3 0 7 7 1)
;;    #(t_4 #\4 0 8 8 1))

;;  '((t_num (t_0)
;;           (t_1)
;;           (t_2)
;;           (t_3)
;;           (t_4)
;;           (t_5)
;;           (t_6)
;;           (t_7)
;;           (t_8)
;;           (uid_1)))

;;  )



;; (testcase

;;  '((t_0 . "0")
;;    (t_1 . "1")
;;    (t_2 . "2")
;;    (t_3 . "3")
;;    (t_4 . "4")
;;    (t_5 . "5")
;;    (t_6 . "6")
;;    (t_7 . "7")
;;    (t_8 . "8")
;;    (t_? . (class alphabetic)))

;;  "1x371634"

;;  '(#(t_1 #\1 0 1 1 1)
;;    #(uid_2 #\x 0 2 2 1)
;;    #(t_3 #\3 0 3 3 1)
;;    #(t_7 #\7 0 4 4 1)
;;    #(t_1 #\1 0 5 5 1)
;;    #(t_6 #\6 0 6 6 1)
;;    #(t_3 #\3 0 7 7 1)
;;    #(t_4 #\4 0 8 8 1))

;;  '((t_? (uid_1) (uid_2) (uid_3)))

;;  )


;; (testcase

;;  '((t_0 . "0")
;;    (t_1 . "1")
;;    (t_2 . "2")
;;    (t_3 . "3")
;;    (t_4 . "4")
;;    (t_5 . "5")
;;    (t_6 . "6")
;;    (t_7 . "7")
;;    (t_8 . "8")
;;    (t_? . (class alphanum)))

;;  "1x371634"

;;  '(#(t_1 #\1 0 1 1 1)
;;    #(uid_3 #\x 0 2 2 1)
;;    #(t_3 #\3 0 3 3 1)
;;    #(t_7 #\7 0 4 4 1)
;;    #(t_1 #\1 0 5 5 1)
;;    #(t_6 #\6 0 6 6 1)
;;    #(t_3 #\3 0 7 7 1)
;;    #(t_4 #\4 0 8 8 1))

;;  '((t_? (t_0)
;;         (t_1)
;;         (t_2)
;;         (t_3)
;;         (t_4)
;;         (t_5)
;;         (t_6)
;;         (t_7)
;;         (t_8)
;;         (uid_1)
;;         (uid_2)
;;         (uid_3)
;;         (uid_4)))

;;  )



;; (testcase

;;  '((t_0 . "0")
;;    (t_1 . "1")
;;    (t_2 . "2")
;;    (t_3 . "3")
;;    (t_4 . "4")
;;    (t_5 . "5")
;;    (t_6 . "6")
;;    (t_7 . "7")
;;    (t_8 . "8")
;;    (t_x . (class alphanum))
;;    (t_a . (class alphabetic)))

;;  "1x371634"

;;  '(#(t_1 #\1 0 1 1 1)
;;    #(uid_2 #\x 0 2 2 1)
;;    #(t_3 #\3 0 3 3 1)
;;    #(t_7 #\7 0 4 4 1)
;;    #(t_1 #\1 0 5 5 1)
;;    #(t_6 #\6 0 6 6 1)
;;    #(t_3 #\3 0 7 7 1)
;;    #(t_4 #\4 0 8 8 1))

;;  '((t_a (uid_1) (uid_2) (uid_3))
;;    (t_x (t_0)
;;         (t_1)
;;         (t_2)
;;         (t_3)
;;         (t_4)
;;         (t_5)
;;         (t_6)
;;         (t_7)
;;         (t_8)
;;         (uid_4)
;;         (uid_1)
;;         (uid_2)
;;         (uid_3)))

;;  )




;; (testcase

;;  '((t_0 . "0")
;;    (t_1 . "1")
;;    (t_2 . "2")
;;    (t_3 . "3")
;;    (t_4 . "4")
;;    (t_5 . "5")
;;    (t_6 . "6")
;;    (t_7 . "7")
;;    (t_8 . "8")
;;    (t_a . (class alphabetic))
;;    (t_x . (class alphanum)))

;;  "1x371634"

;;  '(#(t_1 #\1 0 1 1 1)
;;    #(uid_2 #\x 0 2 2 1)
;;    #(t_3 #\3 0 3 3 1)
;;    #(t_7 #\7 0 4 4 1)
;;    #(t_1 #\1 0 5 5 1)
;;    #(t_6 #\6 0 6 6 1)
;;    #(t_3 #\3 0 7 7 1)
;;    #(t_4 #\4 0 8 8 1))

;;  '((t_x (t_0)
;;         (t_1)
;;         (t_2)
;;         (t_3)
;;         (t_4)
;;         (t_5)
;;         (t_6)
;;         (t_7)
;;         (t_8)
;;         (uid_4)
;;         (uid_1)
;;         (uid_2)
;;         (uid_3))
;;    (t_a (uid_1) (uid_2) (uid_3)))

;;  )




;; (test/string
;;  '((t_0 . "0")
;;    (t_1 . "1")
;;    (t_2 . "2")
;;    (t_3 . "3")
;;    (t_4 . "4")
;;    (t_5 . "5")
;;    (t_6 . "6")
;;    (t_7 . "7")
;;    (t_8 . "8")
;;    (t_a . (class alphabetic))
;;    (t_n . (class numeric))
;;    (t_x . (class alphanum)))

;;  "1x371634"

;;  '(#(t_1 #\1 0 1 1 1)
;;    #(uid_2 #\x 0 2 2 1)
;;    #(t_3 #\3 0 3 3 1)
;;    #(t_7 #\7 0 4 4 1)
;;    #(t_1 #\1 0 5 5 1)
;;    #(t_6 #\6 0 6 6 1)
;;    #(t_3 #\3 0 7 7 1)
;;    #(t_4 #\4 0 8 8 1))

;;  '((t_x (t_0)
;;         (t_1)
;;         (t_2)
;;         (t_3)
;;         (t_4)
;;         (t_5)
;;         (t_6)
;;         (t_7)
;;         (t_8)
;;         (uid_4)
;;         (uid_1)
;;         (uid_2)
;;         (uid_3))
;;    (t_n (t_0)
;;         (t_1)
;;         (t_2)
;;         (t_3)
;;         (t_4)
;;         (t_5)
;;         (t_6)
;;         (t_7)
;;         (t_8)
;;         (uid_4))
;;    (t_a (uid_1) (uid_2) (uid_3)))

;;  )




;; (testcase

;;  '((t_0 . "0")
;;    (t_1 . "1")
;;    (t_2 . "2")
;;    (t_3 . "3")
;;    (t_4 . "4")
;;    (t_5 . "5")
;;    (t_6 . "6")
;;    (t_7 . "7")
;;    (t_8 . "8")
;;    (t_x . "x3")
;;    (t_a . (class alphabetic))
;;    (t_n . (class numeric))
;;    (t_z . (class alphanum)))

;;  "1x371634"

;;  '(#(t_1 #\1 0 1 1 1)
;;    #(uid_1 #\x 0 2 2 1)
;;    #(t_3 #\3 0 3 3 1)
;;    #(t_7 #\7 0 4 4 1)
;;    #(t_1 #\1 0 5 5 1)
;;    #(t_6 #\6 0 6 6 1)
;;    #(t_3 #\3 0 7 7 1)
;;    #(t_4 #\4 0 8 8 1))

;;  '((t_z (t_0)
;;         (t_1)
;;         (t_2)
;;         (t_3)
;;         (t_4)
;;         (t_5)
;;         (t_6)
;;         (t_7)
;;         (t_8)
;;         (uid_5)
;;         (uid_2)
;;         (uid_1)
;;         (uid_3)
;;         (uid_4))
;;    (t_n (t_0)
;;         (t_1)
;;         (t_2)
;;         (t_3)
;;         (t_4)
;;         (t_5)
;;         (t_6)
;;         (t_7)
;;         (t_8)
;;         (uid_5))
;;    (t_a (uid_2) (uid_1) (uid_3) (uid_4))
;;    (t_x (uid_1 t_3)))

;;  )



;; (testcase

;;  '((t_0 . "0")
;;    (t_1 . "1")
;;    (t_2 . "2")
;;    (t_3 . "3")
;;    (t_4 . "4")
;;    (t_5 . "5")
;;    (t_6 . "6")
;;    (t_7 . "7")
;;    (t_8 . "8")
;;    (t_x . "x3")
;;    (uid_1 . (class alphabetic))
;;    (t_n . (class numeric))
;;    (t_z . (class alphanum)))

;;  "1x371634"

;;  '(#(t_1 #\1 0 1 1 1)
;;    #(uid_2 #\x 0 2 2 1)
;;    #(t_3 #\3 0 3 3 1)
;;    #(t_7 #\7 0 4 4 1)
;;    #(t_1 #\1 0 5 5 1)
;;    #(t_6 #\6 0 6 6 1)
;;    #(t_3 #\3 0 7 7 1)
;;    #(t_4 #\4 0 8 8 1))

;;  '((t_z (t_0)
;;         (t_1)
;;         (t_2)
;;         (t_3)
;;         (t_4)
;;         (t_5)
;;         (t_6)
;;         (t_7)
;;         (t_8)
;;         (uid_6)
;;         (uid_3)
;;         (uid_2)
;;         (uid_4)
;;         (uid_5))
;;    (t_n (t_0)
;;         (t_1)
;;         (t_2)
;;         (t_3)
;;         (t_4)
;;         (t_5)
;;         (t_6)
;;         (t_7)
;;         (t_8)
;;         (uid_6))
;;    (uid_1 (uid_3) (uid_2) (uid_4) (uid_5))
;;    (t_x (uid_2 t_3)))

;;  )




;; (testcase

;;  '((t_0 . "0")
;;    (t_1 . "1")
;;    (t_2 . "2")
;;    (t_3 . "3")
;;    (t_4 . "4")
;;    (t_5 . "5")
;;    (t_6 . "6")
;;    (t_7 . "7")
;;    (t_8 . "8")
;;    (c_x . "x3")
;;    (t_a . (class alphabetic))
;;    (t_n . (class numeric))
;;    (t_x . (class alphanum)))

;;  "1x371634"

;;  '(#(t_1 #\1 0 1 1 1)
;;    #(uid_1 #\x 0 2 2 1)
;;    #(t_3 #\3 0 3 3 1)
;;    #(t_7 #\7 0 4 4 1)
;;    #(t_1 #\1 0 5 5 1)
;;    #(t_6 #\6 0 6 6 1)
;;    #(t_3 #\3 0 7 7 1)
;;    #(t_4 #\4 0 8 8 1))

;;  '((t_x (t_0)
;;         (t_1)
;;         (t_2)
;;         (t_3)
;;         (t_4)
;;         (t_5)
;;         (t_6)
;;         (t_7)
;;         (t_8)
;;         (uid_5)
;;         (uid_2)
;;         (uid_1)
;;         (uid_3)
;;         (uid_4))
;;    (t_n (t_0)
;;         (t_1)
;;         (t_2)
;;         (t_3)
;;         (t_4)
;;         (t_5)
;;         (t_6)
;;         (t_7)
;;         (t_8)
;;         (uid_5))
;;    (t_a (uid_2) (uid_1) (uid_3) (uid_4))
;;    (c_x (uid_1 t_3)))

;;  )



;; (testcase

;;  '((t_0 . "0")
;;    (t_1 . "1")
;;    (t_2 . "2")
;;    (t_3 . "3")
;;    (t_4 . "4")
;;    (t_5 . "5")
;;    (t_6 . "6")
;;    (t_7 . "7")
;;    (t_8 . "8")
;;    (t_12 . "12")
;;    (t_num . (class numeric)))

;;  "1123412"

;;  '(#(t_1 #\1 0 1 1 1)
;;    #(t_1 #\1 0 2 2 1)
;;    #(t_2 #\2 0 3 3 1)
;;    #(t_3 #\3 0 4 4 1)
;;    #(t_4 #\4 0 5 5 1)
;;    #(t_1 #\1 0 6 6 1)
;;    #(t_2 #\2 0 7 7 1))

;;  '((t_num (t_0)
;;           (t_1)
;;           (t_2)
;;           (t_3)
;;           (t_4)
;;           (t_5)
;;           (t_6)
;;           (t_7)
;;           (t_8)
;;           (uid_1))
;;    (t_12 (t_1 t_2)))

;;  )


;; (testcase

;;  '((t_1 . "1"))

;;  ""

;;  '()

;;  '()

;;  )



;; (testcase

;;  '((t_A . "A") (t_B . "B"))

;;  "AB"

;;  '(#(t_A #\A 0 1 1 1)
;;    #(t_B #\B 0 2 2 1))

;;  '()

;;  )



;; (testcase

;;  '((t_AB . "AB"))

;;  "AB"

;;  '(#(uid_1 #\A 0 1 1 1)
;;    #(uid_2 #\B 0 2 2 1))

;;  '((t_AB (uid_1 uid_2)))

;;  )



;; (testcase

;;  '((t_num . (class numeric)))

;;  "123"

;;  '(#(t_num #\1 0 1 1 1)
;;    #(t_num #\2 0 2 2 1)
;;    #(t_num #\3 0 3 3 1))

;;  '()

;;  )



;; (testcase

;;  '((t_A . "A")
;;    (t_num . (class numeric)))

;;  "A1"

;;  '(#(t_A #\A 0 1 1 1)
;;    #(t_num #\1 0 2 2 1))

;;  '()

;;  )



;; (testcase

;;  '((t_AB . "AB")
;;    (t_num . (class numeric)))

;;  "AB1"

;;  '(#(uid_1 #\A 0 1 1 1)
;;    #(uid_2 #\B 0 2 2 1)
;;    #(t_num #\1 0 3 3 1))

;;  '((t_AB (uid_1 uid_2)))

;;  )



;; (testcase

;;  '((t_A . "A")
;;    (t_AB . "AB")
;;    (t_num . (class numeric)))

;;  "AAB1"

;;  '(#(t_A #\A 0 1 1 1)
;;    #(t_A #\A 0 2 2 1)
;;    #(uid_1 #\B 0 3 3 1)
;;    #(t_num #\1 0 4 4 1))

;;  '((t_AB (t_A uid_1)))

;;  )



;; (testcase

;;  '((t_A . "A"))

;;  "AAA"

;;  '(#(t_A #\A 0 1 1 1)
;;    #(t_A #\A 0 2 2 1)
;;    #(t_A #\A 0 3 3 1))

;;  '()

;;  )



;; (testcase

;;  '((t_AB . "AB"))

;;  "ABAB"

;;  '(#(uid_1 #\A 0 1 1 1)
;;    #(uid_2 #\B 0 2 2 1)
;;    #(uid_1 #\A 0 3 3 1)
;;    #(uid_2 #\B 0 4 4 1))

;;  '((t_AB (uid_1 uid_2)))

;;  )



;; (testcase

;;  '((t_num . (class numeric))
;;    (t_any . (class any)))

;;  "A1"

;;  '(#(uid_1 #\A 0 1 1 1)
;;    #(t_num #\1 0 2 2 1))

;;  '((t_any (t_num)
;;           (uid_1)
;;           (uid_2)
;;           (uid_3)
;;           (uid_4)
;;           (uid_5)))

;;  )



;; (testcase

;;  '((t_AB1 . "AB1")
;;    (t_num . (class numeric)))

;;  "AB1"

;;  '(#(uid_2 #\A 0 1 1 1)
;;    #(uid_3 #\B 0 2 2 1)
;;    #(uid_1 #\1 0 3 3 1))

;;  '((t_num (uid_1) (uid_4))
;;    (t_AB1 (uid_2 uid_3 uid_1)))

;;  )



;; (testcase

;;  '((t_A . "A")
;;    (t_any . (class any)))

;;  "A"

;;  '(#(t_A #\A 0 1 1 1))

;;  '((t_any (uid_1)
;;           (t_A)
;;           (uid_2)
;;           (uid_3)
;;           (uid_4)
;;           (uid_5)
;;           (uid_6)))

;;  )



;; (testcase

;;  '((t_num . (class numeric)))

;;  "123"

;;  '(#(t_num #\1 0 1 1 1)
;;    #(t_num #\2 0 2 2 1)
;;    #(t_num #\3 0 3 3 1))

;;  '()

;;  )



;; (testcase

;;  '((t_alpha . (class alphabetic)))

;;  "ABC"

;;  '(#(uid_1 #\A 0 1 1 1)
;;    #(uid_1 #\B 0 2 2 1)
;;    #(uid_1 #\C 0 3 3 1))

;;  '((t_alpha (uid_1) (uid_2) (uid_3)))

;;  )



;; (testcase

;;  '((t_alnum . (class alphanum)))

;;  "A1"

;;  '(#(uid_2 #\A 0 1 1 1)
;;    #(uid_1 #\1 0 2 2 1))

;;  '((t_alnum (uid_1) (uid_2) (uid_3) (uid_4)))

;;  )




(testcase

 ;; Duplicated token test.

 '((t_0 . #\0)
   (t_1 . #\1)
   (t_o . #\0)
   (t_i . #\1)
   )

 "0101011101"

 '(#(t_0 #\0 0 1 1 1)
   #(t_1 #\1 0 2 2 1)
   #(t_0 #\0 0 3 3 1)
   #(t_1 #\1 0 4 4 1)
   #(t_0 #\0 0 5 5 1)
   #(t_1 #\1 0 6 6 1)
   #(t_1 #\1 0 7 7 1)
   #(t_1 #\1 0 8 8 1)
   #(t_0 #\0 0 9 9 1)
   #(t_1 #\1 0 10 10 1)
   )

 '((t_i t_1) (t_o t_0))

 )



;;
;;
;;   ▄▄▄▄▄▄
;;   █       ▄ ▄▄   ▄ ▄▄   ▄▄▄    ▄ ▄▄          ▄▄▄    ▄▄▄    ▄▄▄    ▄▄▄    ▄▄▄
;;   █▄▄▄▄▄  █▀  ▀  █▀  ▀ █▀ ▀█   █▀  ▀        █▀  ▀  ▀   █  █   ▀  █▀  █  █   ▀
;;   █       █      █     █   █   █            █      ▄▀▀▀█   ▀▀▀▄  █▀▀▀▀   ▀▀▀▄
;;   █▄▄▄▄▄  █      █     ▀█▄█▀   █            ▀█▄▄▀  ▀▄▄▀█  ▀▄▄▄▀  ▀█▄▄▀  ▀▄▄▄▀
;;
;;


(test-error

 `((t_1 . "1")
   (t_2 . "2")
   (t_3 . "3"))

 "1234"

 'unrecognized-character

 )



(test-error

 `((t_1 . "1")
   (t_2 . "2")
   (t_3 . "3"))

 "abcd"

 'unrecognized-character

 )



(test-error

 '((t_0 . #\0)
   (t_1 . #\1)
   )

 "01301"

 'unrecognized-character

 )



(test-error

 '((t_0 . #\0)
   (t_1 . #\1)
   (t_0 . #\3)
   )

 "0101"

 'model-type-error

 )


;; ;; 13. All Characters Unrecognized
;; (test-error `((t_A . "A")) "BCD" 'unrecognized-character)

;; ;; 14. Mix of Recognized and Unrecognized Characters
;; (test-error `((t_A . "A")) "ABC" 'unrecognized-character)

;; ;; 15. First Character Unrecognized
;; (test-error `((t_A . "A")) "BAA" 'unrecognized-character)

;; ;; 16. Last Character Unrecognized
;; (test-error `((t_A . "A")) "AAB" 'unrecognized-character)

;; ;; 17. Middle Character Unrecognized
;; (test-error `((t_A . "A")) "ABA" 'unrecognized-character)


;; (test-error
;;  '((t_0 . "0")
;;    (t_1 . "1")
;;    (t_2 . "2")
;;    (t_3 . "3")
;;    (t_4 . "4")
;;    (t_5 . "5")
;;    (t_6 . "6")
;;    (t_x . (class bad-class-name))
;;    (t_7 . "7")
;;    (t_8 . "8")
;;    (t_9 . "9"))

;;  "19371634"

;;  'undefined-reference-in-binding

;;  )
