


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
         (labelinglogic:model:alpha-rename result))

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



(testcase

 ;; Simple factor out.

 :model
 '((rule1 (or (constant 5) (constant 6))))

 :expected
 '((rule1 (or uid_1 uid_2))
   (uid_1 (constant 5))
   (uid_2 (constant 6)))

 )




(testcase

 ;; Simple factor out of duplicates.

 :model
 '((rule1 (or (constant 5) (constant 6) (constant 5))))

 :expected
 '((rule1 (or uid_1 uid_2 uid_3))
   (uid_1 (constant 5))
   (uid_2 (constant 6))
   (uid_3 (constant 5)))

 )


(testcase

 ;; Nested factor out.

 :model
 '((rule1 (or (constant 5) rule2 (constant 6)))
   (rule2 (or (constant 7) (constant 8))))

 :expected
 '((rule1 (or uid_1 rule2 uid_2))
   (rule2 (or uid_3 uid_4))
   (uid_1 (constant 5))
   (uid_2 (constant 6))
   (uid_3 (constant 7))
   (uid_4 (constant 8)))

 )




(testcase

 ;; Nested factor out with duplicates.

 :model
 '((rule1 (or (constant 5) rule2 (constant 6)))
   (rule2 (or (constant 7) (constant 5))))

 :expected
 '((rule1 (or uid_1 rule2 uid_2))
   (rule2 (or uid_3 uid_4))
   (uid_1 (constant 5))
   (uid_2 (constant 6))
   (uid_3 (constant 7))
   (uid_4 (constant 5)))

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
 '((just-5 (constant 5))
   (another-5 (constant 5))
   )

 :expected
 '((just-5 (constant 5))
   (another-5 (constant 5)))

 )



(testcase

 ;; Duplicate bindings of equal expressions [2].

 :model
 '((just-5 (constant 5))
   (another-5 (constant 5))
   (something-that-uses-5 (or (constant 5) (constant 3)))
   )

 :expected
 '((just-5 (constant 5))
   (another-5 (constant 5))
   (something-that-uses-5 (or uid_1 uid_2))
   (uid_1 (constant 5))
   (uid_2 (constant 3)))

 )






(testcase

 ;; Complex nested factor out with duplicates across different rules.

 :model
 '((rule1 (or (constant 5) rule2 (constant 6) rule3))
   (rule2 (or (constant 7) (constant 5)))
   (rule3 (or (constant 5) (constant 5) (constant 8)))
   (rule4 (or rule1 rule2 rule3)))

 :expected
 '((rule1 (or uid_1 rule2 uid_2 rule3))
   (rule2 (or uid_3 uid_4))
   (rule3 (or uid_5 uid_6 uid_7))
   (rule4 (or rule1 rule2 rule3))
   (uid_1 (constant 5))
   (uid_2 (constant 6))
   (uid_3 (constant 7))
   (uid_4 (constant 5))
   (uid_5 (constant 5))
   (uid_6 (constant 5))
   (uid_7 (constant 8)))

 )


(testcase

 ;; Simple lists.

 :model
 '((just-5 (constant 5))
   (some-list (list (constant 3) (constant 5))))

 :expected
 '((just-5 (constant 5))
   (some-list (list uid_1 uid_2))
   (uid_1 (constant 3))
   (uid_2 (constant 5)))

 )



(testcase

 ;; Simple lists [2].

 :model
 `((t_1 (constant #\1))
   (t_2 (constant #\2))
   (t_3 (constant #\3))
   (t_x (list (constant #\x) (constant #\3))))

 :expected
 '((t_1 (constant #\1))
   (t_2 (constant #\2))
   (t_3 (constant #\3))
   (t_x (list uid_1 uid_2))
   (uid_1 (constant #\x))
   (uid_2 (constant #\3)))

 )




(testcase

 ;; Embeded lists.

 :model
 `((t_1 (constant #\1))
   (t_2 (constant #\2))
   (t_3 (constant #\3))
   (t_x (or (list (constant #\x) (constant #\3))
            (constant #\2))))

 :expected
 '((t_1 (constant #\1))
   (t_2 (constant #\2))
   (t_3 (constant #\3))
   (t_x (or uid_3 uid_4))
   (uid_1 (constant #\x))
   (uid_2 (constant #\3))
   (uid_3 (list uid_1 uid_2))
   (uid_4 (constant #\2)))

 )



(testcase

 ;; Simple ands.

 :model
 '((just-5 (constant 5))
   (some-and (and (r7rs odd?) (not (constant 5)))))

 :expected
 '((just-5 (constant 5))
   (some-and (and uid_1 uid_3))
   (uid_1 (r7rs odd?))
   (uid_2 (constant 5))
   (uid_3 (not uid_2)))

 )



(testcase

 ;; Duble ands.

 :model
 '((just-5 (constant 5))
   (some-and (and (r7rs odd?) (not (constant 5))))
   (other-and (and (r7rs odd?) (not (constant 5)))))

 :expected
 '((just-5 (constant 5))
   (some-and (and uid_1 uid_3))
   (other-and (and uid_4 uid_6))
   (uid_1 (r7rs odd?))
   (uid_2 (constant 5))
   (uid_3 (not uid_2))
   (uid_4 (r7rs odd?))
   (uid_5 (constant 5))
   (uid_6 (not uid_5)))

 )


