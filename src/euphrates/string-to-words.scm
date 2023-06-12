


;; TODO: make single for guile + racket

(cond-expand
 (guile

  (define (string->words str)
    (string-tokenize str))

  )

 (racket

  (define (string->words str)
    (string-split str))

  ))

