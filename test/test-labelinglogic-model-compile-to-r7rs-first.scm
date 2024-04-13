
;;
;;
;;  ▄▄▄▄▄▄▄                 ▄                           ▄
;;     █     ▄▄▄    ▄▄▄   ▄▄█▄▄          ▄▄▄    ▄▄▄   ▄▄█▄▄  ▄   ▄  ▄▄▄▄
;;     █    █▀  █  █   ▀    █           █   ▀  █▀  █    █    █   █  █▀ ▀█
;;     █    █▀▀▀▀   ▀▀▀▄    █            ▀▀▀▄  █▀▀▀▀    █    █   █  █   █
;;     █    ▀█▄▄▀  ▀▄▄▄▀    ▀▄▄         ▀▄▄▄▀  ▀█▄▄▀    ▀▄▄  ▀▄▄▀█  ██▄█▀
;;                                                                  █
;;                                                                  ▀

(define-syntax check-compiled
  (syntax-rules ()
    ((_ model expected)
     (let ()
       (define result
         (labelinglogic:model:compile-to-r7rs/first
          model))

       (unless (equal? expected result)
         (debugs result))

       (assert= expected result)))))

(define-syntax check-interpretation
  (syntax-rules ()
    ((_ model input)
     (let ()
       (define compiled
         (labelinglogic:model:compile-to-r7rs/first
          model))

       (define compiled/imported
         (labelinglogic:interpret-r7rs-code compiled))

       (define interpreted
         (labelinglogic:model:interpret/first
          model))

       (define compiled-result
         (map compiled/imported input))

       (define interpreted-result
         (map interpreted input))

       (unless (equal? compiled-result interpreted-result)
         (debugs interpreted-result))

       (assert= compiled-result interpreted-result)))))

(define-syntax testcase
  (syntax-rules (:model :expected :input)
    ((_ :model model :expected expected :input input)
     (begin
       (check-compiled model expected)
       (check-interpretation model input)
       ))))



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

 :input
 (string->list "hello world!")

 )





(testcase

 ;; Large case

 :model
 '((t_an (and alphanum (not (= #\5))))
   (t_bn (and alphanum (not (= #\7))))
   (t_cn (and (not (= #\5)) alphanum))
   (t_dn (and alphanum (not (= #\7)) (not (= #\8))))
   (t_en (and alphanum (not (= #\7)) (not (= #\.))))
   (t_fn (or t_an t_bn t_3))
   (t_3  (= #\3))
   (t_8  (= #\8))
   (any (or alphanum whitespace))
   (alphanum (or alphabetic numeric))
   (alphabetic (or upcase lowercase))
   (upcase (r7rs char-upper-case?))
   (lowercase (r7rs char-lower-case?))
   (numeric (r7rs char-numeric?))
   (whitespace (r7rs char-whitespace?))
   )

 :expected
 '(lambda (x)
    (cond
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
     (else #f)))

 :input
 (string->list "hello world!123456789")

 )




(testcase

 ;; Realistic case

 :model
 '((t_0 (= #\0))
   (t_1 (= #\1))
   (t_2 (= #\2))
   (t_3 (= #\3))
   (t_4 (= #\4))
   (t_5 (= #\5))
   (t_6 (= #\6))
   (t_7 (= #\7))
   (t_8 (= #\8))
   (t_9 (= #\9))
   (r_class_whitespace
    (r7rs (lambda (c) (and (char? c) (char-whitespace? c)))))
   (t_q (= #\"))
   (t_s (= #\\))
   (uid_1 (= #\+))
   (uid_2 (= #\-))
   (uid_3 (= #\*))
   (uid_4 (= #\/))
   (uid_5 (r7rs (lambda (c)
                  (and (char? c)
                       (char-alphabetic? c)
                       (char-upper-case? c)))))
   (uid_6 (r7rs (lambda (c)
                  (and (char? c)
                       (char-alphabetic? c)
                       (char-lower-case? c)))))
   (uid_7 (r7rs (lambda (c)
                  (and (char? c)
                       (char-alphabetic? c)
                       (not (char-upper-case? c))
                       (not (char-lower-case? c))))))
   (uid_8 (and (r7rs (lambda (c) (and (char? c) (char-numeric? c))))
               (not (= #\0))
               (not (= #\9))
               (not (= #\8))
               (not (= #\7))
               (not (= #\6))
               (not (= #\5))
               (not (= #\4))
               (not (= #\3))
               (not (= #\2))
               (not (= #\1))))
   (uid_9 (and (r7rs (lambda (c)
                       (and (char? c)
                            (not (char-alphabetic? c))
                            (not (char-numeric? c))
                            (not (char-whitespace? c)))))
               (not (= #\"))
               (not (= #\\))
               (not (= #\/))
               (not (= #\*))
               (not (= #\-))
               (not (= #\+)))))

 :expected
 '(lambda (x)
    (cond
     ((equal? x #\0) 't_0)
     ((equal? x #\1) 't_1)
     ((equal? x #\2) 't_2)
     ((equal? x #\3) 't_3)
     ((equal? x #\4) 't_4)
     ((equal? x #\5) 't_5)
     ((equal? x #\6) 't_6)
     ((equal? x #\7) 't_7)
     ((equal? x #\8) 't_8)
     ((equal? x #\9) 't_9)
     (((lambda (c) (and (char? c) (char-whitespace? c)))
       x)
      'r_class_whitespace)
     ((equal? x #\") 't_q)
     ((equal? x #\\) 't_s)
     ((equal? x #\+) 'uid_1)
     ((equal? x #\-) 'uid_2)
     ((equal? x #\*) 'uid_3)
     ((equal? x #\/) 'uid_4)
     (((lambda (c)
         (and (char? c)
              (char-alphabetic? c)
              (char-upper-case? c)))
       x)
      'uid_5)
     (((lambda (c)
         (and (char? c)
              (char-alphabetic? c)
              (char-lower-case? c)))
       x)
      'uid_6)
     (((lambda (c)
         (and (char? c)
              (char-alphabetic? c)
              (not (char-upper-case? c))
              (not (char-lower-case? c))))
       x)
      'uid_7)
     ((and ((lambda (c) (and (char? c) (char-numeric? c)))
            x)
           (not (equal? x #\0))
           (not (equal? x #\9))
           (not (equal? x #\8))
           (not (equal? x #\7))
           (not (equal? x #\6))
           (not (equal? x #\5))
           (not (equal? x #\4))
           (not (equal? x #\3))
           (not (equal? x #\2))
           (not (equal? x #\1)))
      'uid_8)
     ((and ((lambda (c)
              (and (char? c)
                   (not (char-alphabetic? c))
                   (not (char-numeric? c))
                   (not (char-whitespace? c))))
            x)
           (not (equal? x #\"))
           (not (equal? x #\\))
           (not (equal? x #\/))
           (not (equal? x #\*))
           (not (equal? x #\-))
           (not (equal? x #\+)))
      'uid_9)
     (else #f)))

 :input
 (string->list
  " 42 + x2 * \"good morning!\" -     y* 59 + \"a \\\" quote\"  + x  ")

 )

