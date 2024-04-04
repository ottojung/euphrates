


;;
;;
;;  ▄▄▄▄▄▄▄                 ▄                           ▄
;;     █     ▄▄▄    ▄▄▄   ▄▄█▄▄          ▄▄▄    ▄▄▄   ▄▄█▄▄  ▄   ▄  ▄▄▄▄
;;     █    █▀  █  █   ▀    █           █   ▀  █▀  █    █    █   █  █▀ ▀█
;;     █    █▀▀▀▀   ▀▀▀▄    █            ▀▀▀▄  █▀▀▀▀    █    █   █  █   █
;;     █    ▀█▄▄▀  ▀▄▄▄▀    ▀▄▄         ▀▄▄▄▀  ▀█▄▄▀    ▀▄▄  ▀▄▄▀█  ██▄█▀
;;                                                                  █
;;                                                                  ▀



(define-syntax testcase
  (syntax-rules (:model :bindings :expected)
    ((_ :model model :expected expected)
     (let ()
       (define result
         (labelinglogic:model:factor-dnf-clauses
          model))

       (define result/alpha
         (labelinglogic:model:alpha-rename '() result))

       (unless (equal? expected result/alpha)
         (debugs result/alpha))

       (assert= expected result/alpha)))))



;;
;;
;;  ▄▄▄▄▄▄▄                 ▄
;;     █     ▄▄▄    ▄▄▄   ▄▄█▄▄          ▄▄▄    ▄▄▄    ▄▄▄    ▄▄▄    ▄▄▄
;;     █    █▀  █  █   ▀    █           █▀  ▀  ▀   █  █   ▀  █▀  █  █   ▀
;;     █    █▀▀▀▀   ▀▀▀▄    █           █      ▄▀▀▀█   ▀▀▀▄  █▀▀▀▀   ▀▀▀▄
;;     █    ▀█▄▄▀  ▀▄▄▄▀    ▀▄▄         ▀█▄▄▀  ▀▄▄▀█  ▀▄▄▄▀  ▀█▄▄▀  ▀▄▄▄▀
;;
;;



;; (testcase

;;  ;; Simple factor out.

;;  :model
;;  '((rule1 (or (= 5) (= 6))))

;;  :expected
;;  '((rule1 (or uid_1 uid_2))
;;    (uid_1 (= 5))
;;    (uid_2 (= 6)))

;;  )




(testcase

 ;; Simple factor out of duplicates.

 :model
 '((rule1 (or (= 5) (= 6) (= 5))))

 :expected
 '((rule1 (or uid_1 uid_2 uid_1))
   (uid_1 (= 5))
   (uid_2 (= 6)))

 )


(testcase

 ;; Nested factor out.

 :model
 '((rule1 (or (= 5) rule2 (= 6)))
   (rule2 (or (= 7) (= 8))))

 :expected
 '((rule1 (or uid_1 rule2 uid_2))
   (rule2 (or uid_3 uid_4))
   (uid_1 (= 5))
   (uid_2 (= 6))
   (uid_3 (= 7))
   (uid_4 (= 8)))

 )




(testcase

 ;; Nested factor out with duplicates.

 :model
 '((rule1 (or (= 5) rule2 (= 6)))
   (rule2 (or (= 7) (= 5))))

 :expected
 '((rule1 (or uid_1 rule2 uid_2))
   (rule2 (or uid_3 uid_1))
   (uid_1 (= 5))
   (uid_2 (= 6))
   (uid_3 (= 7)))

 )



(testcase

 ;; No factoring out needed.

 :model
 '((alphabetic (or upcase lowercase))
   (upcase (r7rs char-upper-case?))
   (lowercase (r7rs char-lower-case?))
   (numeric (r7rs char-numeric?))
   )

 :expected
 '((alphabetic (or upcase lowercase))
   (upcase (r7rs char-upper-case?))
   (lowercase (r7rs char-lower-case?))
   (numeric (r7rs char-numeric?))
   )

 )




(testcase

 ;; Duplicate bindings of equal expressions.

 :model
 '((just-5 (= 5))
   (another-5 (= 5))
   )

 :expected
 '((just-5 (= 5))
   (another-5 just-5))

 )



(testcase

 ;; Duplicate bindings of equal expressions [2].

 :model
 '((just-5 (= 5))
   (another-5 (= 5))
   (something-that-uses-5 (or (= 5) (= 3)))
   )

 :expected
 '((just-5 (= 5))
   (another-5 just-5)
   (something-that-uses-5 (or just-5 uid_1))
   (uid_1 (= 3)))

 )




(testcase

 ;; Bigger nochange.

 :model
 '((any (or alphanum whitespace))
   (alphanum (or alphabetic numeric))
   (alphabetic (or upcase lowercase))
   (upcase (r7rs char-upper-case?))
   (lowercase (r7rs char-lower-case?))
   (numeric (r7rs char-numeric?))
   (whitespace (r7rs char-whitespace?))
   )

 :expected
 '((any (or alphanum whitespace))
   (alphanum (or alphabetic numeric))
   (alphabetic (or upcase lowercase))
   (upcase (r7rs char-upper-case?))
   (lowercase (r7rs char-lower-case?))
   (numeric (r7rs char-numeric?))
   (whitespace (r7rs char-whitespace?)))

 )



(testcase

 ;; Complex nested factor out with duplicates across different rules.

 :model
 '((rule1 (or (= 5) rule2 (= 6) rule3))
   (rule2 (or (= 7) (= 5)))
   (rule3 (or (= 5) (= 5) (= 8)))
   (rule4 (or rule1 rule2 rule3)))

 :expected
 '((rule1 (or uid_1 rule2 uid_2 rule3))
   (rule2 (or uid_3 uid_1))
   (rule3 (or uid_1 uid_1 uid_4))
   (rule4 (or rule1 rule2 rule3))
   (uid_1 (= 5))
   (uid_2 (= 6))
   (uid_3 (= 7))
   (uid_4 (= 8)))

 )


(testcase

 ;; Simple tuples.

 :model
 '((just-5 (= 5))
   (some-tuple (tuple (= 3) (= 5))))

 :expected
 '((just-5 (= 5))
   (some-tuple (tuple (= 3) just-5)))

 )


(testcase

 ;; Simple ands.

 :model
 '((just-5 (= 5))
   (some-and (and (r7rs odd?) (not (= 5)))))

 :expected
 '((just-5 (= 5))
   (some-tuple (tuple (= 3) just-5)))

 )

