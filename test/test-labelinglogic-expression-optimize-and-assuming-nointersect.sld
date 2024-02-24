(define-library
  (test-labelinglogic-expression-optimize-and-assuming-nointersect)
  (import
    (only (data parser-branching-glr)
          parser-branching-glr))
  (import
    (only (data parser-branching-lr)
          parser-branching-lr))
  (import
    (only (data parser-repeating-glr)
          parser-repeating-glr))
  (import
    (only (data parser-repeating-lr)
          parser-repeating-lr))
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates parselynn-load) parselynn-load))
  (import
    (only (euphrates parselynn-run) parselynn-run))
  (import
    (only (euphrates parselynn)
          parselynn
          make-lexical-token))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates with-benchmark-simple)
          with-benchmark/simple))
  (import
    (only (scheme base)
          *
          +
          -
          /
          <
          =
          >
          begin
          car
          cdr
          cond
          define
          else
          equal?
          even?
          if
          lambda
          let
          list
          modulo
          null?
          procedure?
          quasiquote
          quote
          set!
          string->symbol
          unquote
          vector-length
          vector-ref
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-expression-optimize-and-assuming-nointersect.scm")))
    (else (include
            "test-labelinglogic-expression-optimize-and-assuming-nointersect.scm"))))
