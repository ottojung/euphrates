
(define-library
  (euphrates serialization-human)
  (export serialize/human deserialize/human)
  (import
    (only (euphrates assoc-or) assoc-or)
    (only (euphrates const) const)
    (only (euphrates descriptors-registry)
          descriptors-registry-get)
    (only (euphrates raisu) raisu)
    (only (euphrates serialization-sexp-natural)
          deserialize/sexp/natural
          serialize/sexp/natural)
    (only (scheme base)
          and
          apply
          assoc
          begin
          car
          cdr
          cons
          define
          equal?
          lambda
          length
          let*
          list
          list-ref
          list?
          map
          not
          null?
          or
          quote
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/serialization-human.scm")))
    (else (include "serialization-human.scm"))))
