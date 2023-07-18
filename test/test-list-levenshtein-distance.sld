
(define-library
  (test-list-levenshtein-distance)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-levenshtein-distance)
          list-levenshtein-distance))
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          let
          string->list))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-levenshtein-distance.scm")))
    (else (include "test-list-levenshtein-distance.scm"))))
