
(define-library
  (test-parselynn-lr-closure)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates parselynn-end-of-input)
          parselynn:end-of-input))
  (import
    (only (euphrates parselynn-lr-closure)
          parselynn:lr-state:close!))
  (import
    (only (euphrates parselynn-lr-item)
          parselynn:lr-item:advance
          parselynn:lr-item:make))
  (import
    (only (euphrates parselynn-lr-state)
          parselynn:lr-state:add!
          parselynn:lr-state:make
          parselynn:lr-state:print))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base)
          *
          +
          =
          _
          begin
          define
          define-syntax
          let
          list
          quasiquote
          quote
          string->symbol
          syntax-rules
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-lr-closure.scm")))
    (else (include "test-parselynn-lr-closure.scm"))))
