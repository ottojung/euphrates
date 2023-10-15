
(define (convert-number-base/number/generic outbase x)
  (define r3 (number->radix3 outbase x))
  (radix3->string r3))

(define (convert-number-base/string/generic inbase outbase s)
  (define r3 (string->radix3 inbase s))
  (define cr3 (radix3:change-base r3 outbase))
  (radix3->string cr3))

(define convert-number-base
  (case-lambda
   ((outbase x)
    (convert-number-base/generic outbase x))
   ((inbase outbase x)
    (convert-number-base/generic inbase outbase x))))

(define convert-number-base/generic
  (case-lambda
   ((outbase x)
    (convert-number-base/number/generic outbase x))
   ((inbase outbase x)
    (convert-number-base/string/generic inbase outbase x))))
