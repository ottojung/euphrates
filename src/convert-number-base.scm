
%run guile

%use (number-list->number number->number-list) "./number-list.scm"
%use (alphanum/alphabet alphanum/alphabet/index) "./alphanum-alphabet.scm"
%use (memconst) "./memconst.scm"
%use (hashmap) "./hashmap.scm"
%use (hashmap-ref hashmap-set!) "./ihashmap.scm"
%use (list-span) "./list-span.scm"
%use (raisu) "./raisu.scm"

;; NOTE: input is a list of characters or a string!
%var convert-number-base
%var convert-number-base:max-base

(define convert-number-base:max-base
  (vector-length alphanum/alphabet))

(define (convert-number-base/number outbase x)
  (define (get-char n) (vector-ref alphanum/alphabet n))

  (when (> outbase convert-number-base:max-base)
    (raisu 'OUT-OF-RANGE-ERROR
           'only-small-bases-are-supported
           outbase convert-number-base:max-base))

  (let ()
    (define-values (rwp0 rfp0)
      (number->number-list outbase x))
    (define rwp1 (map get-char rwp0))
    (define rwp (if (null? rwp1) (list #\0) rwp1))
    (define rfp (map get-char rfp0))
    (if (null? rfp)
        rwp
        (append rwp (list #\.) rfp))))

(define (convert-number-base/list inbase outbase L)
  (when (> (max inbase outbase) convert-number-base:max-base)
    (raisu 'OUT-OF-RANGE-ERROR
           'only-small-bases-are-supported
           inbase outbase convert-number-base:max-base))

  (let ()
    (define-values (wp0 fp0) (list-span (lambda (x) (not (equal? x #\.))) L))
    (define fp1 (if (null? fp0) fp0 (cdr fp0)))
    (define wp (map alphanum/alphabet/index wp0))
    (define fp (map alphanum/alphabet/index fp1))
    (define x (number-list->number inbase wp fp))
    (convert-number-base/number outbase x)))

(define convert-number-base
  (case-lambda
   ((outbase x)
    (convert-number-base/number outbase x))
   ((inbase outbase x)
    (cond
     ((list? x)
      (convert-number-base/list inbase outbase x))
     ((string? x)
      (list->string (convert-number-base/list
                     inbase outbase (string->list x))))
     (else
      (raisu 'TYPE-ERROR 'expected-list-or-string x))))))
