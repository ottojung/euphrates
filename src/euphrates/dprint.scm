
(cond-expand
 (guile
  (define-module (euphrates dprint)
    :export (dprint)
    :use-module ((euphrates dprint-p) :select (dprint#p)))))



(define dprint
  (lambda args
    (apply (dprint#p) args)))


