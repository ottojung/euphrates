
(define-library
  (test-list-permutations)
  (import
    (only (euphrates assert-equal-hs) assert=HS))
  (import
    (only (euphrates list-permutations)
          list-permutations))
  (import
    (only (scheme base)
          begin
          cond-expand
          let
          list
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-permutations.scm")))
    (else (include "test-list-permutations.scm"))))
