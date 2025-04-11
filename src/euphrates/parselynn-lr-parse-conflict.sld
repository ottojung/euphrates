
(define-library
  (euphrates parselynn-lr-parse-conflict)
  (export
    parselynn:lr-parse-conflict:make
    parselynn:lr-parse-conflict?
    parselynn:lr-parse-conflict:add!
    parselynn:lr-parse-conflict:state
    parselynn:lr-parse-conflict:symbol
    parselynn:lr-parse-conflict:actions)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          begin
          define
          equal?
          list
          member
          quote
          unless
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-parse-conflict.scm")))
    (else (include "parselynn-lr-parse-conflict.scm"))))
