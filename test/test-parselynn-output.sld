
(define-library
  (test-parselynn-output)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates parselynn) parselynn))
  (import
    (only (euphrates list-length-geq-q)
          list-length=<?))
  (import
    (only (scheme base)
          *
          +
          -
          /
          <
          =
          begin
          define
          get-output-string
          let
          list?
          open-output-string
          quasiquote
          set!
          string-length
          string?
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-parselynn-output.scm")))
    (else (include "test-parselynn-output.scm"))))
