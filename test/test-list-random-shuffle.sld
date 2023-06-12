
(define-library
  (test-list-random-shuffle)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates list-random-shuffle)
          list-random-shuffle)
    (only (euphrates with-randomizer-seed)
          with-randomizer-seed)
    (only (scheme base) begin let quote set!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-random-shuffle.scm")))
    (else (include "test-list-random-shuffle.scm"))))
