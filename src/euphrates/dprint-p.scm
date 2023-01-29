
(cond-expand
 (guile
  (define-module (euphrates dprint-p)
    :export (#{dprint#p}#)
    :use-module ((euphrates dprint-p-default) :select (dprint#p-default)))))



(define dprint#p
  (make-parameter dprint#p-default))

