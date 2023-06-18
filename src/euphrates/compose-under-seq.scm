
(define-syntax compose-under-seq-helper
  (syntax-rules ()
    ((_ input op buf ())
     (lambda (input) buf))
    ((_ input op buf (f . fs))
     (compose-under-seq-helper
      input op
      (let ((x buf))
        (op x (f x)))
      fs))))

(define-syntax compose-under-seq
  (syntax-rules ()
    ((_ operation . composites)
     (compose-under-seq-helper input operation input composites))))
