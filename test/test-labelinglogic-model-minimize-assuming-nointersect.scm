

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
    ((_ :model model :bindings bindings :expected expected)
     (let ()
       (define names-to-export
         (list->hashset
          (map labelinglogic:binding:name bindings)))

       (define model-full
         (labelinglogic:model:append model bindings))

       (define result
         (labelinglogic:model:minimize/assuming-nointersect
          names-to-export model-full))

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



(testcase

 :model
 `((any (or alphanum whitespace))
   (alphanum (or alphabetic numeric))
   (alphabetic (or upcase lowercase))
   (upcase (r7rs char-upper-case?))
   (lowercase (r7rs char-lower-case?))
   (numeric (r7rs char-numeric?))
   (whitespace (r7rs char-whitespace?))
   )

 :bindings
 `((t_an (and numeric (not (= #\3))))
   (t_bn (and numeric (not (= #\4))))
   (t_3  (= #\9))
   )

 :expected
 '((t_an (or t_3 uid_1 uid_3))
   (t_bn (or t_3 uid_1 uid_2))
   (t_3 (= #\9))
   (uid_1 (and (r7rs char-numeric?)
               (not (= #\3))
               (not (= #\4))
               (not (= #\9))))
   (uid_2 (= #\3))
   (uid_3 (= #\4)))

 )




(testcase

 :model
 `((any (or alphanum whitespace))
   (alphanum (or alphabetic numeric))
   (alphabetic (or upcase lowercase))
   (upcase (r7rs char-upper-case?))
   (lowercase (r7rs char-lower-case?))
   (numeric (r7rs char-numeric?))
   (whitespace (r7rs char-whitespace?))
   )

 :bindings
 `((t_an (and numeric (not (= #\3))))
   (t_bn (and numeric (not (= #\4))))
   (t_3  (= #\9))
   (t_8  (= #\8))
   )

 :expected
 '((t_an (or t_3 t_8 uid_1 uid_3))
   (t_bn (or t_3 t_8 uid_1 uid_2))
   (t_3 (= #\9))
   (t_8 (= #\8))
   (uid_1 (and (r7rs char-numeric?)
               (not (= #\3))
               (not (= #\4))
               (not (= #\9))
               (not (= #\8))))
   (uid_2 (= #\3))
   (uid_3 (= #\4)))

 )





(testcase

 :model
 `((any (or alphanum whitespace))
   (alphanum (or alphabetic numeric))
   (alphabetic (or upcase lowercase))
   (upcase (r7rs char-upper-case?))
   (lowercase (r7rs char-lower-case?))
   (numeric (r7rs char-numeric?))
   (whitespace (r7rs char-whitespace?))
   )

 :bindings
 `((t_an (and numeric (not (= #\5))))
   (t_cn (and (not (= #\5)) numeric))
   )

 :expected
 9999

 )





;; (testcase

;;  :model
;;  `((any (or alphanum whitespace))
;;    (alphanum (or alphabetic numeric))
;;    (alphabetic (or upcase lowercase))
;;    (upcase (r7rs char-upper-case?))
;;    (lowercase (r7rs char-lower-case?))
;;    (numeric (r7rs char-numeric?))
;;    (whitespace (r7rs char-whitespace?))
;;    )

;;  :bindings
;;  `((t_an (and alphanum (not (= #\5))))
;;    (t_bn (and alphanum (not (= #\7))))
;;    (t_cn (and (not (= #\5)) alphanum))
;;    (t_dn (and alphanum (not (= #\7)) (not (= #\8))))
;;    (t_en (and alphanum (not (= #\7)) (not (= #\.))))
;;    (t_fn (or t_an t_bn t_3))
;;    (t_3  (= #\3))
;;    (t_8  (= #\8))
;;    )

;;  :expected
;;  '((t_an (or uid_1 uid_2 t_8 t_3 uid_3 uid_5))
;;    (t_bn (or uid_1 uid_2 t_8 t_3 uid_3 uid_4))
;;    (t_cn (or (r7rs char-upper-case?)
;;              (r7rs char-lower-case?)
;;              (= #\8)
;;              (= #\3)
;;              (and (r7rs char-numeric?)
;;                   (not (= #\5))
;;                   (not (= #\7))
;;                   (not (= #\8))
;;                   (not (= #\3)))
;;              (= #\7)))
;;    (t_dn (or uid_1 uid_2 t_3 uid_3 uid_4))
;;    (t_en (or (r7rs char-upper-case?)
;;              (r7rs char-lower-case?)
;;              (= #\8)
;;              (= #\3)
;;              (and (r7rs char-numeric?)
;;                   (not (= #\5))
;;                   (not (= #\7))
;;                   (not (= #\8))
;;                   (not (= #\3)))
;;              (= #\5)))
;;    (t_fn (or t_8 t_3 uid_3 uid_5 uid_1 uid_2 uid_4))
;;    (t_3 (= #\3))
;;    (t_8 (= #\8))

;;    (uid_1 (r7rs char-upper-case?))
;;    (uid_2 (r7rs char-lower-case?))
;;    (uid_3 (and (r7rs char-numeric?)
;;                (not (= #\5))
;;                (not (= #\7))
;;                (not (= #\8))
;;                (not (= #\3))))
;;    (uid_4 (= #\5))
;;    (uid_5 (= #\7)))

;;  )

