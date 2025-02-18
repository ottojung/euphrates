
(define-library
  (test-parselynn-build-nullable-prefix-grammar)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates
            parselynn-build-nullable-prefix-grammar)
          parselynn:build-nullable-prefix-grammar))
  (import
    (only (scheme base)
          _
          begin
          define
          define-syntax
          equal?
          let
          quasiquote
          quote
          syntax-rules
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-build-nullable-prefix-grammar.scm")))
    (else (include
            "test-parselynn-build-nullable-prefix-grammar.scm"))))
