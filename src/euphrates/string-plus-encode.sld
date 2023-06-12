
(define-library
  (euphrates string-plus-encode)
  (export
    string-plus-encode
    string-plus-encode/generic
    string-plus-encoding-make)
  (import
    (only (euphrates alphanum-alphabet)
          alphanum/alphabet
          alphanum/alphabet/index)
    (only (euphrates call-with-output-string)
          call-with-output-string)
    (only (euphrates convert-number-base)
          convert-number-base/generic)
    (only (euphrates negate) negate)
    (only (srfi srfi-13) string-index)
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
          when)
    (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/string-plus-encode.scm")))
    (else (include "string-plus-encode.scm"))))
