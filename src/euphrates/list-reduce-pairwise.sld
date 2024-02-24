
(define-library
  (euphrates list-reduce-pairwise)
  (export list-reduce/pairwise)
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-has?
          make-hashset))
  (import
    (only (scheme base)
          +
          -
          <
          begin
          define
          equal?
          if
          let
          list->vector
          unless
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
