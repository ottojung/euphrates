
(cond-expand
 (guile
  (define-module (euphrates tilda-s)
    :export (~s))))


(define (~s x)
  (with-output-to-string
    (lambda _
      (write x))))
