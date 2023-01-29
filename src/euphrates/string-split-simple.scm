
(cond-expand
 (guile
  (define-module (euphrates string-split-simple)
    :export (string-split/simple))))


(cond-expand
 (guile

  (define string-split/simple string-split)

  )

 (racket

  (define [string-split/simple str delim]
    (if (char? delim)
    (string-split str (string delim) #:trim? #f)
    (string-split str delim #:trim? #f)))

  ))

