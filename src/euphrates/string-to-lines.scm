
(cond-expand
 (guile
  (define-module (euphrates string-to-lines)
    :export (string->lines)
    :use-module ((euphrates string-split-simple) :select (string-split/simple)))))



(define (string->lines str)
  (string-split/simple str #\newline))

