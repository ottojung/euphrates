
(define-library
  (euphrates bnf-alist-start-symbol)
  (export bnf-alist:start-symbol)
  (import
    (only (euphrates bnf-alist-empty-huh)
          bnf-alist:empty?))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          begin
          car
          define
          if
          list
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-start-symbol.scm")))
    (else (include "bnf-alist-start-symbol.scm"))))
