
(define-library
  (test-big-random-int)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates big-random-int) big-random-int))
  (import
    (only (euphrates with-randomizer-seed)
          with-randomizer-seed))
  (import
    (only (scheme base) begin cond-expand define let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-big-random-int.scm")))
    (else (include "test-big-random-int.scm"))))
