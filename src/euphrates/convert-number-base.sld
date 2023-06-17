
(define-library
  (euphrates convert-number-base)
  (export
    convert-number-base
    convert-number-base/generic
    convert-number-base:default-max-base)
  (import
    (only (euphrates alphanum-alphabet)
          alphanum/alphabet
          alphanum/alphabet/index))
  (import (only (euphrates fp) fp))
  (import
    (only (euphrates list-span-while)
          list-span-while))
  (import
    (only (euphrates number-list)
          number->number-list
          number-list->number))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          >
          append
          begin
          cdr
          cond
          define
          define-values
          else
          equal?
          if
          lambda
          let
          list
          list->string
          list?
          map
          max
          not
          null?
          quote
          string->list
          string?
          vector-length
          vector-ref
          when))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/convert-number-base.scm")))
    (else (include "convert-number-base.scm"))))
