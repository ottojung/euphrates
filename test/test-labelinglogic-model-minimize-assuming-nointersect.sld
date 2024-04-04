
(define-library
  (test-labelinglogic-model-minimize-assuming-nointersect)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates labelinglogic-model-alpha-rename)
          labelinglogic:model:alpha-rename))
  (import
    (only (euphrates labelinglogic)
          labelinglogic:init))
  (import
    (only (scheme base)
          =
          and
          begin
          define
          let
          not
          or
          quasiquote
          quote))
  (import
    (only (scheme char)
          char-lower-case?
          char-numeric?
          char-upper-case?
          char-whitespace?))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-model-minimize-assuming-nointersect.scm")))
    (else (include
            "test-labelinglogic-model-minimize-assuming-nointersect.scm"))))
