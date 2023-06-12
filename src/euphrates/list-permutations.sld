
(define-library
  (euphrates list-permutations)
  (export list-permutations)
  (import
    (only (scheme base)
          +
          -
          <
          <=
          >
          begin
          cadr
          car
          case
          cddr
          cdr
          cond
          cons
          define
          else
          if
          length
          let
          let*
          list
          make-vector
          null?
          or
          quasiquote
          quote
          reverse
          unquote
          unquote-splicing
          vector-ref
          vector-set!)
    (only (scheme cxr) cadddr caddr cddddr cdddr))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-permutations.scm")))
    (else (include "list-permutations.scm"))))
