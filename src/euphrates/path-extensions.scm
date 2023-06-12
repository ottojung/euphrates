

;; Returns leftmost extension with a dot or ""
;; Only returns "meaningful" extensions


(define (path-extensions str)
  (define parts
    (reverse (string-split/simple str #\.)))
  (let loop ((parts parts) (buf ""))
    (if (or (null? parts)
            (null? (cdr parts)))
        buf
        (let* ((s (car parts))
               (L (string->list s)))
          (cond
           ((null? L) buf)
           ((list-and-map alphanum/alphabet/index L)
            (loop (cdr parts) (string-append "." s buf)))
           (else buf))))))
