
(define-library
  (euphrates parselynn-lr-reduce-action)
  (export
    parselynn:lr-reduce-action:make
    parselynn:lr-reduce-action?
    parselynn:lr-reduce-action:production)
  (import
    (only (euphrates bnf-alist-production-huh)
          bnf-alist:production?))
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          begin
          define
          list
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-reduce-action.scm")))
    (else (include "parselynn-lr-reduce-action.scm"))))
