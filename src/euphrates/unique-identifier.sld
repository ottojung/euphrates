
(define-library
  (euphrates unique-identifier)
  (export
    make-unique-identifier
    unique-identifier?
    with-unique-identifier-context
    unique-identifier->list)
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates hashmap)
          hashmap-count
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          +
          _
          begin
          define
          define-syntax
          if
          lambda
          let
          list
          make-parameter
          parameterize
          quote
          set!
          syntax-rules
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/unique-identifier.scm")))
    (else (include "unique-identifier.scm"))))
