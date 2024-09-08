
(define-library
  (test-parselynn-lr-interpret)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
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
    (only (euphrates parselynn-lr-reject-action)
          parselynn:lr-reject-action:make))
  (import
    (only (euphrates parselynn-token)
          parselynn:token:make))
  (import
    (only (scheme base)
          *
          +
          <
          =
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
          map
          parameterize
          quasiquote
          quote
          string->symbol
          syntax-rules
          unless
          unquote
          vector))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-lr-interpret.scm")))
    (else (include "test-parselynn-lr-interpret.scm"))))
