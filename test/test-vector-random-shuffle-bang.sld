
(define-library
  (test-vector-random-shuffle-bang)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates vector-random-shuffle-bang)
          vector-random-shuffle!))
  (import
    (only (euphrates with-randomizer-seed)
          with-randomizer-seed))
  (import
    (only (scheme base)
          begin
          cond-expand
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
