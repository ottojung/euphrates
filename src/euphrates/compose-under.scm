
(cond-expand
 (guile
  (define-module (euphrates compose-under)
    :export (compose-under)
    :use-module ((euphrates syntax-reverse) :select (syntax-reverse)))))



(define-syntax compose-under-cont
  (syntax-rules ()
    ((_ op buf) (op . buf))))

(define-syntax compose-under-helper
  (syntax-rules ()
    [(_ args op buf ())
     (lambda args
       (syntax-reverse (compose-under-cont op) buf))]
    [(_ args op buf (f . fs))
     (compose-under-helper
      args op
      ((apply f args) . buf)
      fs)]))

(define-syntax compose-under
  (syntax-rules ()
    ((_ operation . composites)
     (compose-under-helper args operation () composites))))
