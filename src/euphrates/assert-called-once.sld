
(define-library
  (euphrates assert-called-once)
  (export
    assert-called-once
    with-called-once-extent)
  (import
    (only (euphrates box) box-ref box-set! make-box))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          _
          begin
          cond
          define
          define-syntax
          else
          let
          let*
          make-parameter
          not
          parameterize
          quote
          syntax-rules
          when))
  (cond-expand
    (guile (import
             (only (guile)
                   include-from-path
                   parameter?
                   hash-table?))
           (begin
             (include-from-path
               "euphrates/assert-called-once.scm")))
    (else (include "assert-called-once.scm"))))
