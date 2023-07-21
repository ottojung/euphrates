
(define (string-null-or-whitespace? str)
  (let loop ((i (- (string-length str) 1)))
    (if (< i 0) #t
        (and (char-whitespace? (string-ref str i)) ;; TODO: is this O(1)?
             (loop (- i 1))))))
