
(cond-expand
 (guile
  (define-module (euphrates words-to-string)
    :export (words->string))))


(define (words->string lns)
  (string-join (filter (negate string-null?) lns) " "))
