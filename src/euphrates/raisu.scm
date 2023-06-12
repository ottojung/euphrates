

;; One-way exceptions (non-recoverable / not continuable)

(cond-expand
 (guile
  (define (raisu x . xs)
    (apply throw (cons x xs))))
 (racket
  (define (raisu x . xs)
    (raise (cons x xs)))))
