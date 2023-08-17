
;; Simple one-way exceptions (unrecoverable / uncontinuable)

(define (raisu type . args)
  (generic-error
   (list
    (cons generic-error:message-key
          (string-append "Error of type "
                         (~a type)
                         " was raisued"))
    (cons generic-error:type-key type)
    (cons generic-error:irritants-key args))))
