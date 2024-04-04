

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
    `((t_an (and numeric (not (= #\3))))
      (t_bn (and numeric (not (= #\4))))
      (t_3  (= #\9))))

  (assert=

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

   (labelinglogic:model:alpha-rename
    '() (labelinglogic:init
         model bindings))))


