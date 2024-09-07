
(define-library
  (test-parselynn-lr-interpret)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates const) const))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates list-to-iterator)
          list->iterator))
  (import
    (only (euphrates parselynn-lr-compute-parsing-table)
          parselynn:lr-compute-parsing-table))
  (import
    (only (euphrates parselynn-lr-interpret)
          parselynn:lr-interpret))
  (import
    (only (scheme base)
          *
          +
          <
          >
          _
          begin
          cons
          define
          define-syntax
          equal?
          lambda
          let
          list
          make-parameter
          parameterize
          quasiquote
          quote
          syntax-rules
          unless
          vector))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-lr-interpret.scm")))
    (else (include "test-parselynn-lr-interpret.scm"))))
