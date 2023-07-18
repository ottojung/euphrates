
(define-library
  (test-list-random-shuffle)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-random-shuffle)
          list-random-shuffle))
  (import
    (only (euphrates with-randomizer-seed)
          with-randomizer-seed))
  (import
    (only (scheme base)
          begin
          cond-expand
          let
          quote
          set!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-random-shuffle.scm")))
    (else (include "test-list-random-shuffle.scm"))))
