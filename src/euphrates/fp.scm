
(cond-expand
 (guile
  (define-module (euphrates fp)
    :export (fp))))


;; creates a Function on Pairs
(define-syntax fp
  (syntax-rules ()
    ((_ (arg1-name . arg*-name) . bodies)
     (lambda (lst-argument)
       (apply (lambda (arg1-name . arg*-name) . bodies) lst-argument)))))
