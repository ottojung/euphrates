


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
 '((t_an (or (= #\9)
             (and (r7rs char-numeric?)
                  (not (= #\3))
                  (not (= #\4))
                  (not (= #\9)))
             (= #\4)))

   (t_bn (or (= #\9)
             (and (r7rs char-numeric?)
                  (not (= #\3))
                  (not (= #\4))
                  (not (= #\9)))
             (= #\3)))

   (t_3 (= #\9)))

 )

