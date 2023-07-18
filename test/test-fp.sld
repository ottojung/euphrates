
(define-library
  (test-fp)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates fp) fp))
  (import
    (only (euphrates list-zip-with) list-zip-with))
  (import (only (euphrates range) range))
  (import
    (only (scheme base)
          *
          +
          begin
          cond-expand
          let
          list
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-fp.scm")))
    (else (include "test-fp.scm"))))
