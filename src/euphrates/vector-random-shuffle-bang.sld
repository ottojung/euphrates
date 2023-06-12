
(define-library
  (euphrates vector-random-shuffle-bang)
  (export vector-random-shuffle!)
  (import
    (only (euphrates big-random-int) big-random-int)
    (only (scheme base)
          +
          -
          >
          begin
          define
          if
          let
          let*
          vector-length
          vector-ref
          vector-set!
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/vector-random-shuffle-bang.scm")))
    (else (include "vector-random-shuffle-bang.scm"))))
