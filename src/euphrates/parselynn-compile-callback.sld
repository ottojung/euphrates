
(define-library
  (euphrates parselynn-compile-callback)
  (export parselynn:compile-callback)
  (import
    (only (euphrates bnf-alist-production-rhs)
          bnf-alist:production:rhs))
  (import (only (euphrates const) const))
  (import
    (only (euphrates
            parselynn-default-compilation-environment)
          parselynn:default-compilation-environment))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          +
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
          let
          list
          list?
          map
          pair?
          procedure?
          quasiquote
          quote
          string->symbol
          string-append
          symbol?
          unless
          unquote))
  (import (only (scheme eval) eval))
  (cond-expand
    (guile (import (only (srfi srfi-1) iota)))
    (else (import (only (srfi 1) iota))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-compile-callback.scm")))
    (else (include "parselynn-compile-callback.scm"))))
