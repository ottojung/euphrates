
(define-library
  (euphrates md5)
  (export md5-digest)
  (import (rnrs bytevectors))
  (import (rnrs arithmetic bitwise))
  (import (rnrs arithmetic fixnums))
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base)
          *
          +
          -
          <
          <=
          =
          >
          apply
          begin
          cond
          define
          do
          else
          for-each
          if
          lambda
          let
          list->vector
          make-bytevector
          map
          min
          modulo
          number->string
          or
          quote
          string-append
          values
          vector-copy
          vector-map
          vector-ref
          vector-set!
          zero?)
    (only (scheme case-lambda) case-lambda)
    (only (srfi srfi-1) count iota))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/md5.scm")))
    (else (include "md5.scm"))))
