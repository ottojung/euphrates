
(cond-expand
 (guile
  (define-module (euphrates string-to-words)
    :export (string->words))))


;; TODO: make single for guile + racket

(cond-expand
 (guile

  (define (string->words str)
    (filter
     (compose not string-null?)
     (string-split
      str
      (lambda (c)
    (case c
          ((#\newline #\space #\tab) #t)
          (else #f))))))

  ))
(cond-expand
 (racket

  (define (string->words str)
    (string-split str))

  ))

