
(define (nonexistant-key) 'dummy-key)

(define (catch-specific key body handler)
  (guard
   (err1
    ((and (generic-error? err1)
          (equal? key (generic-error:value/unsafe err1 generic-error:type-key nonexistant-key)))
     (handler err1)))
   (body)))
