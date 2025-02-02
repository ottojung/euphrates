
(define-library
  (test-parselynn-ll-interpret)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates list-to-iterator)
          list->iterator))
  (import
    (only (euphrates parselynn-ll-compute-parsing-table)
          parselynn:ll-compute-parsing-table))
  (import
    (only (euphrates parselynn-ll-interpret)
          parselynn:ll-interpret))
  (import
    (only (euphrates parselynn-ll-reject-action)
          parselynn:ll-reject-action:make
          parselynn:ll-reject-action?))
  (import
    (only (euphrates parselynn-token)
          parselynn:token:make))
  (import (only (euphrates raisu) raisu))
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
          if
          lambda
          let
          make-parameter
          map
          quasiquote
          quote
          string->symbol
          syntax-rules
          unless
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-ll-interpret.scm")))
    (else (include "test-parselynn-ll-interpret.scm"))))
