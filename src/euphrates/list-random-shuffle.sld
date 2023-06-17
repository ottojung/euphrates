
(define-library
  (euphrates list-random-shuffle)
  (export list-random-shuffle)
  (import
    (only (euphrates vector-random-shuffle-bang)
          vector-random-shuffle!))
  (import
    (only (scheme base)
          begin
          define
          list->vector
          vector->list))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-random-shuffle.scm")))
    (else (include "list-random-shuffle.scm"))))
