
(define-library
  (euphrates srfi-27-generic)
  (export
    default-random-source
    make-random-source
    random-source?
    random-source-state-ref
    random-source-state-set!
    random-source-randomize!
    random-source-pseudo-randomize!
    random-source-make-integers
    random-source-make-reals)
  (import
    (only (euphrates raisu) raisu)
    (only (euphrates srfi-27-backbone-generator)
          mrg32k3a-pack-state
          mrg32k3a-random-integer
          mrg32k3a-random-range
          mrg32k3a-random-real
          mrg32k3a-unpack-state)
    (only (euphrates srfi-27-random-source-obj)
          :random-source-current-time
          :random-source-make
          :random-source-make-integers
          :random-source-make-reals
          :random-source-pseudo-randomize!
          :random-source-randomize!
          :random-source-state-ref
          :random-source-state-set!
          :random-source?)
    (only (scheme base)
          *
          +
          -
          /
          <
          <=
          =
          >=
          and
          apply
          begin
          car
          cdr
          cond
          cons
          define
          do
          else
          eq?
          even?
          exact?
          expt
          if
          integer?
          lambda
          length
          let
          let*
          list
          list->vector
          list-ref
          list?
          modulo
          not
          null?
          or
          positive?
          quote
          quotient
          real?
          set!
          vector
          vector->list
          vector-ref
          zero?)
    (only (scheme r5rs) exact->inexact))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/srfi-27-generic.scm")))
    (else (include "srfi-27-generic.scm"))))
