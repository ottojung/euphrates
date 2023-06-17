
(define-library
  (euphrates serialization-human)
  (export serialize/human deserialize/human)
  (import (only (euphrates assoc-or) assoc-or))
  (import (only (euphrates const) const))
  (import
    (only (euphrates descriptors-registry)
          descriptors-registry-get))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates serialization-sexp-natural)
          deserialize/sexp/natural
          serialize/sexp/natural))
  (import
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
