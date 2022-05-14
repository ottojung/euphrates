
%run guile

%use (open-cond) "./open-cond.scm"

%var define-open-cond
%var define-open-cond-instance
%var open-cond-lambda

(define-syntax-rule (define-open-cond name)
  (define name (open-cond '())))

(define-syntax-rule (define-open-cond-instance open-cond function)
  (set-open-cond-value!
   open-cond
   (cons function (open-cond-value open-cond))))

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
