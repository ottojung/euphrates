
(define-library
  (euphrates fn-alist)
  (export fn-alist)
  (import (only (euphrates assq-or) assq-or))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          _
          apply
          begin
          define
          define-syntax
          lambda
          let
          map
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/fn-alist.scm")))
    (else (include "fn-alist.scm"))))
