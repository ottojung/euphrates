



(define open-cond? open-cond-predicate)

(define-syntax define-open-cond
  (syntax-rules ()
    ((_ name)
     (define name (open-cond-constructor '())))))

(define-syntax define-open-cond-instance
  (syntax-rules ()
    ((_ open-cond function)
     (set-open-cond-value!
      open-cond
      (cons function (open-cond-value open-cond))))))

(define-syntax open-cond-lambda
  (syntax-rules ()
    ((_ open-cond default)
     (lambda args
       (let ((buf (open-cond-value open-cond)))
         (let loop ((buf buf))
           (if (null? buf) (apply default args)
               (let ((R (apply (car buf) args)))
                 (or R (loop (cdr buf)))))))))
    ((_ open-cond)
     (lambda args
       (let ((buf (open-cond-value open-cond)))
         (let loop ((buf buf))
           (and (not (null? buf))
                (let ((R (apply (car buf) args)))
                  (or R (loop (cdr buf)))))))))))
