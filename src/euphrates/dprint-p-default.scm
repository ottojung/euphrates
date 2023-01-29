
(cond-expand
 (guile
  (define-module (euphrates dprint-p-default)
    :export (#{dprint#p-default}#)
    :use-module ((euphrates printf) :select (printf)))))


(define dprint#p-default printf)

