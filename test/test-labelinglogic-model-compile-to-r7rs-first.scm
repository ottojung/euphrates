
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
  (syntax-rules (:model :expected)
    ((_ :model model :expected expected)
     (let ()
       (define result
         (labelinglogic:model:compile-to-r7rs/first
          model))

       (unless (equal? expected result)
         (debugs result))

       (assert= expected result)))))



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

 ;; Empty case

 :model
 '()

 :expected
 '(lambda (x)
    (cond (else #f)))

 )





(testcase

 ;; Large case

 :model
 '((any (or alphanum whitespace))
   (alphanum (or alphabetic numeric))
   (alphabetic (or upcase lowercase))
   (upcase (r7rs char-upper-case?))
   (lowercase (r7rs char-lower-case?))
   (numeric (r7rs char-numeric?))
   (whitespace (r7rs char-whitespace?))
   (t_an (and alphanum (not (= #\5))))
   (t_bn (and alphanum (not (= #\7))))
   (t_cn (and (not (= #\5)) alphanum))
   (t_dn (and alphanum (not (= #\7)) (not (= #\8))))
   (t_en (and alphanum (not (= #\7)) (not (= #\.))))
   (t_fn (or t_an t_bn t_3))
   (t_3  (= #\3))
   (t_8  (= #\8))
   )

 :expected
 '(lambda (x)
    (cond
     ((or (or (or (char-upper-case? x) (char-lower-case? x))
              (char-numeric? x))
          (char-whitespace? x))
      'any)
     ((or (or (char-upper-case? x) (char-lower-case? x))
          (char-numeric? x))
      'alphanum)
     ((or (char-upper-case? x) (char-lower-case? x))
      'alphabetic)
     ((char-upper-case? x) 'upcase)
     ((char-lower-case? x) 'lowercase)
     ((char-numeric? x) 'numeric)
     ((char-whitespace? x) 'whitespace)
     ((and (or (or (char-upper-case? x) (char-lower-case? x))
               (char-numeric? x))
           (not (equal? x #\5)))
      't_an)
     ((and (or (or (char-upper-case? x) (char-lower-case? x))
               (char-numeric? x))
           (not (equal? x #\7)))
      't_bn)
     ((and (not (equal? x #\5))
           (or (or (char-upper-case? x) (char-lower-case? x))
               (char-numeric? x)))
      't_cn)
     ((and (or (or (char-upper-case? x) (char-lower-case? x))
               (char-numeric? x))
           (not (equal? x #\7))
           (not (equal? x #\8)))
      't_dn)
     ((and (or (or (char-upper-case? x) (char-lower-case? x))
               (char-numeric? x))
           (not (equal? x #\7))
           (not (equal? x #\.)))
      't_en)
     ((or (and (or (or (char-upper-case? x) (char-lower-case? x))
                   (char-numeric? x))
               (not (equal? x #\5)))
          (and (or (or (char-upper-case? x) (char-lower-case? x))
                   (char-numeric? x))
               (not (equal? x #\7)))
          (equal? x #\3))
      't_fn)
     ((equal? x #\3) 't_3)
     ((equal? x #\8) 't_8)
     (else #f)))

 )

