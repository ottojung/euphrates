
(define-library
  (euphrates lalr-lexer-irregex)
  (export make-lalr-lexer/irregex-factory)
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates compose-under) compose-under))
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (euphrates irregex)
          irregex-match-substring
          irregex-search
          sre->irregex))
  (import
    (only (euphrates lalr-parser) make-lexical-token))
  (import
    (only (euphrates list-map-first) list-map-first))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates read-all-port) read-all-port))
  (import
    (only (euphrates source-location)
          make-source-location))
  (import
    (only (scheme base)
          +
          >=
          _
          and
          begin
          car
          cdr
          cons
          current-input-port
          define
          equal?
          if
          lambda
          let
          list
          map
          min
          quasiquote
          quote
          set!
          string-for-each
          string-length
          substring
          unless
          unquote
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-irregex.scm")))
    (else (include "lalr-lexer-irregex.scm"))))
