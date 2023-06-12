
(define-library
  (test-vector-random-shuffle-bang)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates vector-random-shuffle-bang)
          vector-random-shuffle!)
    (only (euphrates with-randomizer-seed)
          with-randomizer-seed)
    (only (scheme base)
          begin
          let
          make-vector
          quote
          vector-set!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-vector-random-shuffle-bang.scm")))
    (else (include "test-vector-random-shuffle-bang.scm"))))
