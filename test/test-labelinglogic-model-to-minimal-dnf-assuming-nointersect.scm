

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
         (labelinglogic:model:to-minimal-dnf/assuming-nointersect
          names-to-export model-full))

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
 `((t_an (and numeric (not (constant #\3))))
   (t_bn (and numeric (not (constant #\4))))
   (t_3  (constant #\9))
   )

 :expected
 '((t_an (or t_3 uid_1 uid_3))
   (t_bn (or t_3 uid_1 uid_2))
   (t_3 (constant #\9))
   (uid_1 (and (r7rs char-numeric?)
               (not (constant #\3))
               (not (constant #\4))
               (not (constant #\9))))
   (uid_2 (constant #\3))
   (uid_3 (constant #\4)))

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
 `((t_an (and numeric (not (constant #\3))))
   (t_bn (and numeric (not (constant #\4))))
   (t_3  (constant #\9))
   (t_8  (constant #\8))
   )

 :expected
 '((t_an (or t_3 t_8 uid_1 uid_3))
   (t_bn (or t_3 t_8 uid_1 uid_2))
   (t_3 (constant #\9))
   (t_8 (constant #\8))
   (uid_1 (and (r7rs char-numeric?)
               (not (constant #\3))
               (not (constant #\4))
               (not (constant #\9))
               (not (constant #\8))))
   (uid_2 (constant #\3))
   (uid_3 (constant #\4)))

 )





(testcase

 :model
 `((any (or numeric whitespace))
   (numeric (r7rs char-numeric?))
   (whitespace (r7rs char-whitespace?))
   )

 :bindings
 `((t_an (and (or numeric whitespace) (not (constant #\5))))
   (t_cn (and (not (constant #\5)) (or numeric whitespace)))
   )

 :expected
 '((t_an (or uid_1 uid_2))
   (t_cn t_an)
   (uid_1 (and (r7rs char-numeric?) (not (constant #\5))))
   (uid_2 (r7rs char-whitespace?)))

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
 `((t_an (and alphanum (not (constant #\5))))
   (t_bn (and alphanum (not (constant #\7))))
   (t_cn (and (not (constant #\5)) alphanum))
   (t_dn (and alphanum (not (constant #\7)) (not (constant #\8))))
   (t_en (and alphanum (not (constant #\7)) (not (constant #\.))))
   (t_fn (or t_an t_bn t_3))
   (t_3  (constant #\3))
   (t_8  (constant #\8))
   )

 :expected
 '((t_an (or uid_1 uid_2 t_8 t_3 uid_3 uid_5))
   (t_bn (or uid_1 uid_2 t_8 t_3 uid_3 uid_4))
   (t_cn t_an)
   (t_dn (or uid_1 uid_2 t_3 uid_3 uid_4))
   (t_en t_bn)
   (t_fn (or t_8 t_3 uid_3 uid_5 uid_1 uid_2 uid_4))
   (t_3 (constant #\3))
   (t_8 (constant #\8))
   (uid_1 (r7rs char-upper-case?))
   (uid_2 (r7rs char-lower-case?))
   (uid_3 (and (r7rs char-numeric?)
               (not (constant #\5))
               (not (constant #\7))
               (not (constant #\8))
               (not (constant #\3))))
   (uid_4 (constant #\5))
   (uid_5 (constant #\7)))

 )










(testcase

 :model
 `()

 :bindings
 '((t_1 (constant #\1))
   (t_2 (constant #\2))
   (t_3 (constant #\3))
   (t_x (tuple (constant #\x) (constant #\3))))

 :expected
 '((t_1 (constant #\1))
   (t_2 (constant #\2))
   (t_3 (constant #\3))
   (t_x (tuple uid_1 t_3))
   (uid_1 (constant #\x)))

 )




(testcase

 :model
 `()

 :bindings
 '((t1 (tuple (constant 1) (constant 1) (constant 1)))
   (t2 (tuple (constant 2) (constant 2) (constant 2))))

 :expected
 '((t1 (tuple uid_1 uid_1 uid_1))
   (t2 (tuple uid_2 uid_2 uid_2))
   (uid_1 (constant 1))
   (uid_2 (constant 2)))

 )
