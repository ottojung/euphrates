
%run guile

%use (memconst) "./memconst.scm"

%var lazy-parameter

(define-syntax lazy-parameter
  (syntax-rules ()
    ((_ initial)
     (let ((p (make-parameter (memconst initial))))
       (case-lambda
        (() ((p)))
        ((value body)
         (let ((mem (memconst (value))))
           (parameterize ((p mem))
             (body)))))))
    ((_ initial converter)
     (let ((p (make-parameter (memconst initial))))
       (case-lambda
        (() ((p)))
        ((value body)
         (let ((mem (memconst (converter (value)))))
           (parameterize ((p mem))
             (body)))))))))

