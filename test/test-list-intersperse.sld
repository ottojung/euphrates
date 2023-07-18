
(define-library
  (test-list-intersperse)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-intersperse)
          list-intersperse))
  (import (only (euphrates range) range))
  (import
    (only (scheme base)
          begin
          cond-expand
          length
          let
          list
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-intersperse.scm")))
    (else (include "test-list-intersperse.scm"))))
