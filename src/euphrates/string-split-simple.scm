
(define (string-split/simple str delim)
  (cond
   ((char? delim)
    (irregex-split delim str))
   ((string? delim)
    (irregex-split (list delim) str))
   (else
    (error "Not a string or character" delim))))
