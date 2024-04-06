
(define-library
  (test-labelinglogic-model-deduplicate-subexpressions)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates labelinglogic-model-alpha-rename)
          labelinglogic:model:alpha-rename))
  (import
    (only (euphrates
            labelinglogic-model-deduplicate-subexpressions)
          labelinglogic:model:deduplicate-subexpressions))
  (import
    (only (scheme base)
          =
          _
          begin
          define
          define-syntax
          equal?
          let
          or
          quasiquote
          quote
          syntax-rules
          unless))
  (import
    (only (scheme char)
          char-lower-case?
          char-numeric?
          char-upper-case?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-model-deduplicate-subexpressions.scm")))
    (else (include
            "test-labelinglogic-model-deduplicate-subexpressions.scm"))))
