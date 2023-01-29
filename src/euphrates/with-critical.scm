
(cond-expand
 (guile
  (define-module (euphrates with-critical)
    :export (with-critical))))


(define-syntax-rule (with-critical critical-func . bodies)
  (critical-func
   (lambda [] . bodies)))


