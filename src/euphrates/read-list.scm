


(define read-list
  (case-lambda
   (() (read-list (current-input-port)))
   ((p)
    (let lp ()
      (let ((r (read p)))
        (if (eof-object? r)
            '()
            (cons r (lp))))))))

