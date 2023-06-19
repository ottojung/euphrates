
(define (string-split/simple str delim)
  (cond
   ((char? delim)
    (string-split str (string delim) #:trim? #f))
   (else
    (raisu 'string-split-expected-a-character-for-delim delim))))
