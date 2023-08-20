
(define-library
  (test-display-alist-as-json)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates display-alist-as-json)
          display-alist-as-json))
  (import (only (euphrates negate) negate))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          begin
          define
          let
          quote
          vector))
  (import (only (scheme char) char-whitespace?))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-filter)))
    (else (import (only (srfi 13) string-filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-display-alist-as-json.scm")))
    (else (include "test-display-alist-as-json.scm"))))
