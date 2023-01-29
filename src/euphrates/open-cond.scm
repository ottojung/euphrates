
(cond-expand
 (guile
  (define-module (euphrates open-cond)
    :export (define-open-cond open-cond? define-open-cond-instance open-cond-lambda)
    :use-module ((euphrates open-cond-obj) :select (open-cond-constructor open-cond-predicate open-cond-value set-open-cond-value!)))))



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
