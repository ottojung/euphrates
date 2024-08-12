
(define-library
  (test-parselynn-lr-goto)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates parselynn-end-of-input)
          parselynn:end-of-input))
  (import
    (only (euphrates parselynn-lr-goto)
          parselynn:lr-goto))
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
    (only (scheme base)
          +
          _
          begin
          define
          define-syntax
          let
          quasiquote
          quote
          string->symbol
          syntax-rules
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-parselynn-lr-goto.scm")))
    (else (include "test-parselynn-lr-goto.scm"))))
