
(define-library
  (euphrates parselynn-compile-callback)
  (export parselynn:compile-callback)
  (import
    (only (euphrates
            bnf-alist-production-get-argument-bindings)
          bnf-alist:production:get-argument-bindings))
  (import (only (euphrates const) const))
  (import
    (only (euphrates
            parselynn-default-compilation-environment)
          parselynn:default-compilation-environment))
  (import
    (only (scheme base)
          and
          begin
          cadr
          car
          cond
          define
          else
          equal?
          lambda
          length
          list?
          quasiquote
          quote
          unquote))
  (import (only (scheme eval) eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-compile-callback.scm")))
    (else (include "parselynn-compile-callback.scm"))))
