
(define nocase?
  '(lambda (c)
     (and (char? c)
          (char-alphabetic? c)
          (not (char-upper-case? c))
          (not (char-lower-case? c)))))

(define numeric?
  `(lambda (c)
     (and (char? c)
          (char-numeric? c))))



(let ()
  (define model
    `((any (or alphanum upcase))
      (alphanum alphabetic)
      (alphabetic (or upcase (or upcase upcase)))
      (upcase (r7rs char-upper-case?))))

  (labelinglogic:model:check model))






(let ()
  (define model
    `((any (or alphanum upcase))
      (alphanum alphabetic)
      (alphabetic (or any (or upcase upcase)))
      (upcase (r7rs char-upper-case?))))

  (assert-throw
   'model-type-error
   (labelinglogic:model:check model)))







(let ()
  (define model
    `((any (or alphanum whitespace))
      (alphanum (or alphabetic numeric))
      (alphabetic (or upcase lowercase))
      (upcase (r7rs char-upper-case?))
      (lowercase (r7rs char-lower-case?))
      (numeric (r7rs char-numeric?))
      (whitespace (r7rs char-whitespace?))))

  (define bindings
    `((t_an alphanum)
      (t_3  (= #\3))))

  (assert=

   `((t_an (or uid_1 uid_2 t_3 uid_3))
     (t_3 (= #\3))
     (uid_1 (r7rs char-upper-case?))
     (uid_2 (r7rs char-lower-case?))
     (uid_3 (r7rs char-numeric?)))

   ;; `((t_an (or uid_1 uid_2))
   ;;   (t_3 (= #\3))
   ;;   (uid_1 (or uid_3 uid_4))
   ;;   (uid_2 (or t_3 uid_5))
   ;;   (uid_3 (r7rs char-upper-case?))
   ;;   (uid_4 (r7rs char-lower-case?))
   ;;   (uid_5 (r7rs char-numeric?)))

   ;; `((t_an (or uid_1 t_3))
   ;;   (t_3 (= #\3))
   ;;   (uid_1
   ;;    (r7rs (lambda (c) (or
   ;;                       (or (char-upper-case? c)
   ;;                           (char-lower-case? c))
   ;;                       (char-numeric? c))))))

   (labelinglogic:model:alpha-rename
    '() (labelinglogic:init
         model bindings))))







(let ()
  (define model
    `((any (or alphanum whitespace))
      (alphanum (or alphabetic numeric))
      (alphabetic (or upcase lowercase))
      (upcase (r7rs char-upper-case?))
      (lowercase (r7rs char-lower-case?))
      (numeric (r7rs char-numeric?))
      (whitespace (r7rs char-whitespace?))))

  (define bindings
    `((t_an alphanum)
      (t_3  (= #\3))
      (t_4  (= #\4))))

  (assert=

   `((t_an (or uid_1 t_3 t_4))
     (t_3 (= #\3))
     (t_4 (= #\4))
     (uid_1 (r7rs (lambda (c)
                    (or (or (char-upper-case? c)
                            (char-lower-case? c))
                        (char-numeric? c))))))

   (labelinglogic:model:alpha-rename
    '() (labelinglogic:init
         model bindings))))






(let ()
  (define model
    `((whitespace (r7rs char-whitespace?))))

  (define bindings
    `((t_an whitespace)
      (t_4  (or (= #\3) (= #\4)))
      (t_3  (= #\3))))

  (assert=

   `((t_an (r7rs char-whitespace?))
     (t_4 (or t_3 uid_1))
     (t_3 (= #\3))
     (uid_1 (= #\4)))

   (labelinglogic:model:alpha-rename
    '() (labelinglogic:init
         model bindings))))







(let ()
  (define model
    `((whitespace (r7rs char-whitespace?))))

  (define bindings
    `((t_an whitespace)
      (t_4  (or (= #\3) (= #\4) (= #\3)))))

  (assert=

   `((t_an (r7rs char-whitespace?))
     (t_4 (or uid_1 uid_2))
     (uid_1 (= #\3))
     (uid_2 (= #\4)))

   (labelinglogic:model:alpha-rename
    '() (labelinglogic:init
         model bindings))))











(let ()
  (define model
    `((any (or alphanum whitespace))
      (alphanum (or alphabetic numeric))
      (alphabetic (or upcase lowercase))
      (upcase (r7rs char-upper-case?))
      (lowercase (r7rs char-lower-case?))
      (numeric (r7rs char-numeric?))
      (whitespace (r7rs char-whitespace?))))

  (define bindings
    `((t_an alphabetic)
      (t_3  (= #\3))))


  (assert=

   `((t_an (r7rs (lambda (c) (or (char-upper-case? c) (char-lower-case? c)))))
     (t_3 (= #\3)))

   (labelinglogic:model:alpha-rename
    '() (labelinglogic:init
         model bindings))))




(let ()
  (define model
    `((any (or alphanum whitespace))
      (alphanum (or alphabetic numeric))
      (alphabetic (or upcase (or lowercase nocase)))
      (upcase (r7rs char-upper-case?))
      (lowercase (r7rs char-lower-case?))
      (nocase (r7rs ,nocase?))
      (numeric (r7rs char-numeric?))
      (whitespace (r7rs char-whitespace?))))

  (define bindings
    '((t_0 (= #\0))
      (t_1 (= #\1))
      (t_2 (= #\2))
      (t_3 (= #\3))
      (t_4 (= #\4))
      (t_5 (= #\5))
      (t_6 (= #\6))
      (t_7 (= #\7))
      (t_8 (= #\8))
      (t_m (= #\m))
      ;; (c_x (= #\x3))
      (t_a alphabetic)
      (t_n numeric)
      (t_x alphanum)))

  (assert=

   `((t_0 (= #\0))
     (t_1 (= #\1))
     (t_2 (= #\2))
     (t_3 (= #\3))
     (t_4 (= #\4))
     (t_5 (= #\5))
     (t_6 (= #\6))
     (t_7 (= #\7))
     (t_8 (= #\8))
     (t_m (= #\m))
     (t_a (or uid_1 t_m))
     (t_n (or t_0 t_1 t_2 t_3 t_4 t_5 t_6 t_7 t_8 uid_2))
     (t_x (or t_a t_n))
     (uid_1 (r7rs (lambda (c)
                    (or (or (char-upper-case? c)
                            (char-lower-case? c))
                        (and (char? c)
                             (char-alphabetic? c)
                             (not (char-upper-case? c))
                             (not (char-lower-case? c)))))))
     (uid_2 (r7rs char-numeric?)))

   (labelinglogic:model:alpha-rename
    '() (labelinglogic:init
         model bindings)))

  )






(let ()
  (define model
    `((none (r7rs (lambda _ #f)))))

  (define bindings
    `((t_an none)
      (t_4  (or (= 0) (= 1)))))

  (assert=

   `((t_an (r7rs (lambda _ #f)))
     (t_4 (or uid_1 uid_2))
     (uid_1 (= 0))
     (uid_2 (= 1)))

   (labelinglogic:model:alpha-rename
    '() (labelinglogic:init
         model bindings))))



(let ()
  (define model `())

  (define bindings
    `((t_4  (or (= 0) (= 1)))))

  (assert=

   `((t_4 (or uid_1 uid_2))
     (uid_1 (= 0))
     (uid_2 (= 1)))

   (labelinglogic:model:alpha-rename
    '() (labelinglogic:init
         model bindings))))







(let ()
  (define model
    `((numeric (r7rs ,numeric?))))

  (define bindings
    `((t_n numeric)
      (t_4  (tuple (= #\a) (= #\b) (= #\c)))))

  (assert=

   `((t_n (r7rs ,numeric?))
     (t_4 (tuple uid_1 uid_2 uid_3))
     (uid_1 (= #\a))
     (uid_2 (= #\b))
     (uid_3 (= #\c)))

   (labelinglogic:model:alpha-rename
    '() (labelinglogic:init
         model bindings))))




(let ()
  (define model
    `((numeric (r7rs ,numeric?))))

  (define bindings
    `((t_n numeric)
      (t_4  (tuple (= #\3) (= #\4) (= #\5)))))

  (assert=

   `((t_n (r7rs (lambda (c)
                  (and (char? c)
                       (char-numeric? c)))))
     (t_4 (tuple uid_1 uid_2 uid_3))
     (uid_1 (= #\3))
     (uid_2 (= #\4))
     (uid_3 (= #\5)))

   (labelinglogic:model:alpha-rename
    '() (labelinglogic:init
         model bindings))))




(let ()
  (define model
    `((numeric (r7rs ,numeric?))))

  (define bindings
    `((t_n numeric)
      (t_4  (tuple (= #\3) (= #\4) (= #\3)))))

  (assert=

   `((t_n (r7rs (lambda (c)
                  (and (char? c)
                       (char-numeric? c)))))
     (t_4 (tuple uid_1 uid_2 uid_1))
     (uid_1 (= #\3))
     (uid_2 (= #\4)))

   (labelinglogic:model:alpha-rename
    '() (labelinglogic:init
         model bindings))))





(let ()
  (define model
    `((numeric (r7rs ,numeric?))))

  (define bindings
    `((t_n numeric)
      (t_4  (or (= #\3) (= #\4) (= #\3)))))

  (define opt
    (labelinglogic:model:alpha-rename
     '() (labelinglogic:init
          model bindings)))

  (define universe
    (labelinglogic:model:calculate-biggest-universe
     opt 't_4))

  (assert= universe '(#\3 #\4))
  )


(let ()
  (define model
    `((a (or (= 3) (= 4) (= 3)))
      (b (or (= 5) (= 3) (= 4)))))

  (define universe
    (labelinglogic:model:calculate-biggest-universe
     model '(or a b)))

  (assert= universe '(3 4 5))
  )


(let ()
  (define model
    (labelinglogic:model:alpha-rename
     '() (labelinglogic:init
          '()
          `((a (or (= 3) (= 4) (= 3)))
            (b (or (= 5) (= 3) (= 4)))))))

  (define universe
    (labelinglogic:model:calculate-biggest-universe
     model '(and a b)))

  (assert= universe '(3 4))
  )


(let ()
  (define model
    (labelinglogic:model:alpha-rename
     '() (labelinglogic:init
          '((a (or (= 3) (= 4) (= 3)))
            (b (or (= 5) (= 3) (= 4))))
          `((c (and a b))))))

  (define universe
    (labelinglogic:model:calculate-biggest-universe
     model 'c))

  (assert= universe '(3 4))
  )





(let ()
  (define model
    (labelinglogic:model:alpha-rename
     '() (labelinglogic:init
          '((a (or (= 3) (= 4) (= 3)))
            (b (or (= 5) (= 3) (= 4))))
          `((c (and a b))))))

  (define universe
    (labelinglogic:model:calculate-biggest-universe/typed
     model 'c))

  (assert= universe '((= 3) (= 4)))
  )







(let ()
  (define model
    (labelinglogic:model:alpha-rename
     '() (labelinglogic:init
          '((a (or (= 3) (= 4) (= 3)))
            (b (or (= 5) (= 3) (= 4))))
          `((c (or a b))))))

  (define universe
    (labelinglogic:model:calculate-biggest-universe/typed
     model 'c))

  (assert= universe '((= 3) (= 4) (= 5)))
  )




(exit 0) ;; nochecking ;; DEBUG




(let ()
  (define model
    (labelinglogic:model:alpha-rename
     '() (labelinglogic:init
          '((a (or (= 3) (= 4) (= 3)))
            (b (or (= 5) (= 3) (= 4))))
          `((c (tuple a b))))))

  (define universe
    (labelinglogic:model:calculate-biggest-universe/typed
     model 'c))

  (assert=
   universe
   `(#(tuple 3 5)
     #(tuple 3 3)
     #(tuple 3 4)
     #(tuple 4 5)
     #(tuple 4 3)
     #(tuple 4 4)))

  )




(let ()
  (define model
    (labelinglogic:model:alpha-rename
     '() (labelinglogic:init
          '((a (or (= 3) (= 4)))
            (b (or (= 5) (= 3))))
          `((c (tuple a b a))))))

  (define universe
    (labelinglogic:model:calculate-biggest-universe/typed
     model 'c))

  (assert=
   universe

   0

   ;; `(#(tuple 3 5 3)
   ;;   #(tuple 3 5 4)
   ;;   #(tuple 3 3 3)
   ;;   #(tuple 3 3 4)
   ;;   #(tuple 4 5 3)
   ;;   #(tuple 4 5 4)
   ;;   #(tuple 4 3 3)
   ;;   #(tuple 4 3 4))

   )

  )
