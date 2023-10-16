
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

  (define nocase?
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

   `((t_x (or t_a t_n))
     (t_a (or (ref 0) t_m))
     (t_m (= #\m))
     (t_n (or t_0 t_1 t_2 t_3 t_4 t_5 t_6 t_7 t_8 (ref 1)))
     (t_8 (= #\8))
     (t_7 (= #\7))
     (t_6 (= #\6))
     (t_5 (= #\5))
     (t_4 (= #\4))
     (t_3 (= #\3))
     (t_2 (= #\2))
     (t_1 (= #\1))
     (t_0 (= #\0))
     ((ref 0)
      (r7rs (lambda (c)
              (or (char-upper-case? c)
                  (char-lower-case? c)
                  (and (char-alphabetic? c)
                       (not (char-upper-case? c))
                       (not (char-lower-case? c)))))))
     ((ref 1) (r7rs char-numeric?)))

   (labelinglogic:init
    model bindings))

  )
