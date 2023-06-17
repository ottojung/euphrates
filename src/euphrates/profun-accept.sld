
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
    (only (euphrates assq-set-value) assq-set-value))
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates profun-meta-key)
          profun-meta-key))
  (import
    (only (euphrates profun-varname-q)
          profun-varname?))
  (import (only (euphrates raisu) raisu))
  (import
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
          unless))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun-accept.scm")))
    (else (include "profun-accept.scm"))))
