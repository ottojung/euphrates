


;; NOTE: input is a list of characters or a string!

(define convert-number-base:default-max-base
  (vector-length alphanum/alphabet))

(define (convert-number-base/number/generic alphabet outbase x)
  (define max-base (vector-length alphabet))
  (define (get-char n) (vector-ref alphabet n))

  (when (> outbase max-base)
    (raisu 'OUT-OF-RANGE-ERROR
           'only-small-bases-are-supported
           outbase max-base))

  (let ()
    (define-values (rwp0 rfp0)
      (number->radix-list outbase x))
    (define rwp1 (map get-char rwp0))
    (define rwp (if (null? rwp1) (list #\0) rwp1))
    (define rfp (map get-char rfp0))
    (if (null? rfp)
        rwp
        (append rwp (list #\.) rfp))))

(define (convert-number-base/list/generic alphabet inbase outbase L)
  (define max-base (vector-length alphabet))
  (when (> (max inbase outbase) max-base)
    (raisu 'OUT-OF-RANGE-ERROR
           'only-small-bases-are-supported
           inbase outbase max-base))

  (let ()
    (define-values (wp0 fp0) (list-span-while (lambda (x) (not (equal? x #\.))) L))
    (define fp1 (if (null? fp0) fp0 (cdr fp0)))
    (define wp (map alphanum/alphabet/index wp0))
    (define fp (map alphanum/alphabet/index fp1))
    (define x (radix-list->number inbase wp fp))
    (convert-number-base/number/generic alphabet outbase x)))

(define convert-number-base
  (case-lambda
   ((outbase x)
    (convert-number-base/generic alphanum/alphabet outbase x))
   ((inbase outbase x)
    (convert-number-base/generic alphanum/alphabet inbase outbase x))))

(define convert-number-base/generic
  (case-lambda
   ((alphabet outbase x)
    (convert-number-base/number/generic alphabet outbase x))
   ((alphabet inbase outbase x)
    (cond
     ((list? x)
      (convert-number-base/list/generic alphabet inbase outbase x))
     ((string? x)
      (list->string (convert-number-base/list/generic
                     alphabet inbase outbase (string->list x))))
     (else
      (raisu 'TYPE-ERROR 'expected-list-or-string x))))))
