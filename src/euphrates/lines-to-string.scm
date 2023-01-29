
(cond-expand
 (guile
  (define-module (euphrates lines-to-string)
    :export (lines->string))))


(define (lines->string lns)
  (string-join lns "\n"))

