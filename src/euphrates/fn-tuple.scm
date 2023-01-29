
(cond-expand
 (guile
  (define-module (euphrates fn-tuple)
    :export (fn-tuple)
    :use-module ((euphrates raisu) :select (raisu)))))



(define (fn-tuple . funcs)
  (if (null? funcs)
      (raisu 'null-funcs-to-fn-tuple)
      (lambda (lst)
        (map (lambda (f tuple-element) (f tuple-element)) funcs lst))))
