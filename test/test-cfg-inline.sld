
(define-library
  (test-cfg-inline)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates cfg-inline) CFG-inline))
  (import (only (euphrates debug) debug))
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          let
          quasiquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-cfg-inline.scm")))
    (else (include "test-cfg-inline.scm"))))
