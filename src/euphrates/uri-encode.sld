
(define-library
  (euphrates uri-encode)
  (export uri-encode)
  (import
    (only (euphrates call-with-output-string)
          call-with-output-string))
  (import (only (euphrates negate) negate))
  (import
    (only (euphrates uri-safe-alphabet)
          uri-safe/alphabet/index))
  (import
    (only (scheme base)
          +
          <
          begin
          bytevector-length
          bytevector-u8-ref
          define
          if
          lambda
          let
          let*
          number->string
          string
          string-for-each
          when))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme char) string-upcase))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-index)))
    (else (import (only (srfi 13) string-index))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import
             (only (ice-9 iconv)
                   bytevector->string
                   string->bytevector))
           (import
             (only (rnrs bytevectors)
                   bytevector-length
                   bytevector-u8-ref))
           (begin
             (include-from-path "euphrates/uri-encode.scm")))
    (else (include "uri-encode.scm"))))
