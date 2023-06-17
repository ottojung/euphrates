
(define-library
  (euphrates string-plus-encode)
  (export
    string-plus-encode
    string-plus-encode/generic
    string-plus-encoding-make)
  (import
    (only (euphrates alphanum-alphabet)
          alphanum/alphabet
          alphanum/alphabet/index))
  (import
    (only (euphrates call-with-output-string)
          call-with-output-string))
  (import
    (only (euphrates convert-number-base)
          convert-number-base/generic))
  (import (only (euphrates negate) negate))
  (import
    (only (scheme base)
          +
          -
          <
          <=
          begin
          char->integer
          cond
          define
          define-values
          else
          if
          lambda
          let
          let*
          list->string
          max
          set!
          string
          string-for-each
          string-length
          values
          vector-length
          vector-ref
          when))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-index)))
    (else (import (only (srfi 13) string-index))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/string-plus-encode.scm")))
    (else (include "string-plus-encode.scm"))))
