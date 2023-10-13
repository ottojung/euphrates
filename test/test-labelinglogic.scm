
(let ()
  (define model
    `((any (or alphanum whitespace))
      (alphanum (or alphabetic numeric))
      (alphabetic (or any (or lowercase nocase)))
      (upcase (r7rs char-upper-case?))
      (lowercase (r7rs char-lower-case?))
      (nocase (r7rs ,char-nocase-alphabetic?))
      (numeric (r7rs char-numeric?))
      (whitespace (r7rs char-whitespace?))))

  (assert-throw
   'model-type-error
   (labelinglogic::model:check model)))

(let ()

  (define char-nocase-alphabetic?
    '(lambda (c)
       (and (char-alphabetic? c)
            (not (char-upper-case? c))
            (not (char-lower-case? c)))))

  (define model
    `((any (or alphanum whitespace))
      (alphanum (or alphabetic numeric))
      (alphabetic (or upcase (or lowercase nocase)))
      (upcase (r7rs char-upper-case?))
      (lowercase (r7rs char-lower-case?))
      (nocase (r7rs ,char-nocase-alphabetic?))
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

   `((t_x union #f)
     (t_a union t_x)
     (upcase (r7rs char-upper-case?) t_a)
     ((class 9)
      (r7rs char-lower-case?) t_a)
     (t_m (= #\m) t_a)
     (nocase (r7rs ,char-nocase-alphabetic?) t_a)
     (t_n union t_x)
     ((class 8)
      (r7rs char-numeric?) t_n)
     (t_8 (= #\8) t_n)
     (t_7 (= #\7) t_n)
     (t_6 (= #\6) t_n)
     (t_5 (= #\5) t_n)
     (t_4 (= #\4) t_n)
     (t_3 (= #\3) t_n)
     (t_2 (= #\2) t_n)
     (t_1 (= #\1) t_n)
     (t_0 (= #\0) t_n))

   (labelinglogic::init
    model bindings))

  )
