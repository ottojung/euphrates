
(define-library
  (euphrates serialization-runnable)
  (export serialize/runnable deserialize/runnable)
  (import
    (only (euphrates assoc-or) assoc-or)
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
          let*
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
               "euphrates/serialization-runnable.scm")))
    (else (include "serialization-runnable.scm"))))
