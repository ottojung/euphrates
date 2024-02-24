
(define-library
  (euphrates list-reduce-pairwise)
  (export list-reduce/pairwise)
  (import
    (only (scheme base)
          +
          -
          <
          begin
          define
          if
          let
          list->vector
          vector->list
          vector-copy
          vector-length
          vector-ref
          vector-set!
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-reduce-pairwise.scm")))
    (else (include "list-reduce-pairwise.scm"))))
