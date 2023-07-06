
(define-library
  (test-list-minimal-element-or-proj)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-minimal-element-or-proj)
          list-minimal-element-or/proj))
  (import
    (only (scheme base)
          <
          begin
          list
          string-length
          string<=?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-minimal-element-or-proj.scm")))
    (else (include "test-list-minimal-element-or-proj.scm"))))
