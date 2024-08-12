
(define-library
  (euphrates parselynn-lr-goto)
  (export parselynn:lr-goto)
  (import
    (only (euphrates parselynn-lr-closure)
          parselynn:lr-closure))
  (import
    (only (euphrates parselynn-lr-item)
          parselynn:lr-item:advance
          parselynn:lr-item:dot-at-end?
          parselynn:lr-item:next-symbol))
  (import
    (only (euphrates parselynn-lr-state)
          parselynn:lr-state:add!
          parselynn:lr-state:foreach-item
          parselynn:lr-state:make))
  (import
    (only (scheme base)
          and
          begin
          define
          equal?
          lambda
          let
          not
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-goto.scm")))
    (else (include "parselynn-lr-goto.scm"))))
