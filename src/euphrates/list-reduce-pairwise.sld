
(define-library
  (euphrates list-reduce-pairwise)
  (export list-reduce/pairwise)
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-has?
          make-hashset))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates range) range))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          +
          -
          <
          =
          _
          and
          begin
          call-with-values
          car
          cdr
          cond
          define
          else
          if
          lambda
          length
          let
          list
          list->vector
          map
          not
          null?
          or
          quote
          reverse
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
