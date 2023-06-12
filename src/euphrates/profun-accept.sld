
(define-library
  (euphrates profun-accept)
  (export
    profun-accept
    make-profun-accept
    profun-accept?
    profun-accept-alist
    profun-accept-ctx
    profun-accept-ctx-changed?
    profun-set
    profun-ctx-set
    profun-set-meta
    profun-set-parameter)
  (import
    (only (euphrates assq-set-value) assq-set-value)
    (only (euphrates define-type9) define-type9)
    (only (euphrates profun-meta-key)
          profun-meta-key)
    (only (euphrates profun-varname-q)
          profun-varname?)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          _
          begin
          define
          define-syntax
          let
          let*
          procedure?
          quote
          syntax-rules
          unless)
    (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun-accept.scm")))
    (else (include "profun-accept.scm"))))
