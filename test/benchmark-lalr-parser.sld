
(define-library
  (benchmark-lalr-parser)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import (only (euphrates const) const))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates lalr-parser)
          lalr-parser
          make-lexical-token))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import
    (only (euphrates with-benchmark-simple)
          with-benchmark/simple))
  (import
    (only (scheme base)
          *
          +
          -
          /
          <
          =
          >
          begin
          car
          cdr
          cond
          define
          else
          equal?
          if
          lambda
          let
          list
          list?
          modulo
          not
          null?
          quasiquote
          quote
          set!
          unquote
          vector-length
          vector-ref
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "benchmark-lalr-parser.scm")))
    (else (include "benchmark-lalr-parser.scm"))))
