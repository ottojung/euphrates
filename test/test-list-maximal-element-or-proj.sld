
(define-library
  (test-list-maximal-element-or-proj)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-maximal-element-or-proj)
          list-maximal-element-or/proj))
  (import
    (only (scheme base)
          >
          begin
          list
          string-length
          string>=?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-maximal-element-or-proj.scm")))
    (else (include "test-list-maximal-element-or-proj.scm"))))
