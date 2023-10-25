
(define nocase?
  '(lambda (c)
     (and (char-alphabetic? c)
          (not (char-upper-case? c))
          (not (char-lower-case? c)))))






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

   `((t_an (or uid_1 t_3))
     (t_3 (= #\3))
     (uid_1 (r7rs (lambda (c)
                    (or (char-upper-case? c)
                        (char-lower-case? c)
                        (char-numeric? c))))))

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
                    (or (char-upper-case? c)
                        (char-lower-case? c)
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
    `((whitespace (r7rs char-whitespace?))))

  (define bindings
    `((t_an whitespace)
      (t_4  (seq (= #\3) (= #\4) (= #\3)))))

  (assert=

   `((t_an (r7rs char-whitespace?))
     (t_4 (seq uid_1 uid_2 uid_3))
     (uid_1 (= #\3))
     (uid_2 (= #\4))
     (uid_3 (= #\3)))

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

   (labelinglogic:init
    model bindings)))






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
                    (or (char-upper-case? c)
                        (char-lower-case? c)
                        (and (char-alphabetic? c)
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






