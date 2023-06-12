


;; Returns procedure that returns #t if applied to itself, #f otherwise
;; But it is probably faster too do (eq? (make-unique) other)
(define (make-unique)
  (let ((euphrates-unique #f))
    (set! euphrates-unique (lambda (other)
                 (eq? other euphrates-unique)))
    euphrates-unique))

