
(define-library
  (euphrates list-reduce-pairwise)
  (export list-reduce/pairwise)
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-has?
          make-hashset))
  (import (only (euphrates range) range))
  (import
    (only (scheme base)
          +
          -
          <
          =
          and
          apply
          begin
          call-with-values
          cond
          define
          define-values
          else
          if
          lambda
          let
          list
          list->vector
          map
          not
          null?
          values
          vector-copy
          vector-length
          vector-ref
          vector-set!
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-reduce-pairwise.scm")))
    (else (include "list-reduce-pairwise.scm"))))
