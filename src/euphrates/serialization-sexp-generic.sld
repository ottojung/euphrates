
(define-library
  (euphrates serialization-sexp-generic)
  (export
    serialize/sexp/generic
    deserialize/sexp/generic)
  (import
    (only (euphrates builtin-type-huh) builtin-type?))
  (import
    (only (euphrates define-type9)
          type9-get-record-descriptor))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          _
          begin
          cond
          define
          else
          if
          lambda
          let
          or
          procedure?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/serialization-sexp-generic.scm")))
    (else (include "serialization-sexp-generic.scm"))))
