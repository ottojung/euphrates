
(define-library
  (euphrates unique-identifier)
  (export
    make-unique-identifier
    unique-identifier?
    with-unique-identifier-context
    unique-identifier->string)
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset-foreach
          hashset?))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          +
          _
          and
          begin
          cond
          define
          define-syntax
          else
          for-each
          if
          lambda
          let
          list
          list?
          make-parameter
          number->string
          or
          pair?
          parameterize
          quote
          set!
          string-append
          syntax-rules
          unless
          vector
          vector-ref
          vector-set!))
  (cond-expand
    (guile (import (only (srfi srfi-1) count)))
    (else (import (only (srfi 1) count))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/unique-identifier.scm")))
    (else (include "unique-identifier.scm"))))
