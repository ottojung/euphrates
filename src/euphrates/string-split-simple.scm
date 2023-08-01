
(cond-expand
 (guile
  (define (string-split/simple str delim)
    (if (string-null? str) '()
        (cond
         ((char? delim)
          (string-split str delim))
         (else
          (raisu 'string-split-expected-a-character-for-delim delim))))))

 (else
  (define (string-split/simple str delim)
    (if (string-null? str) '()
        (cond
         ((char? delim)
          (string-split str (string delim)))
         (else
          (raisu 'string-split-expected-a-character-for-delim delim)))))))
