
(define-library
  (euphrates get-euphrates-revision-title)
  (export get-euphrates-revision-title)
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates system-environment)
          system-environment-get))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          if
          let
          list
          not
          quote
          syntax-rules
          when))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-null?)))
    (else (import (only (srfi 13) string-null?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/get-euphrates-revision-title.scm")))
    (else (include "get-euphrates-revision-title.scm"))))
