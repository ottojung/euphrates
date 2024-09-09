
(define-library
  (test-parselynn-lr-1-compile)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates iterator) iterator:next))
  (import
    (only (euphrates list-to-iterator)
          list->iterator))
  (import
    (only (euphrates parselynn-end-of-input)
          parselynn:end-of-input))
  (import
    (only (euphrates parselynn-lr-1-compile)
          parselynn:lr-1-compile))
  (import
    (only (euphrates parselynn-lr-compute-parsing-table)
          parselynn:lr-compute-parsing-table))
  (import
    (only (euphrates parselynn-lr-interpret)
          parselynn:lr-interpret))
  (import
    (only (euphrates
            parselynn-lr-parsing-table-get-conflicts)
          parselynn:lr-parsing-table:get-conflicts))
  (import
    (only (euphrates parselynn-lr-reject-action)
          parselynn:lr-reject-action:make
          parselynn:lr-reject-action?))
  (import
    (only (euphrates parselynn-token)
          parselynn:token:make))
  (import (only (euphrates raisu) raisu))
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
          if
          lambda
          let
          list
          make-parameter
          map
          pair?
          parameterize
          quasiquote
          quote
          string->symbol
          syntax-rules
          unless
          unquote
          values
          vector))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-lr-1-compile.scm")))
    (else (include "test-parselynn-lr-1-compile.scm"))))
