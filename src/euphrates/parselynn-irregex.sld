
(define-library
  (euphrates parselynn-irregex)
  (export make-parselynn:irregex-factory)
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
    (only (euphrates list-map-first) list-map-first))
  (import
    (only (euphrates parselynn-core)
          make-lexical-token))
  (import (only (euphrates raisu-star) raisu*))
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
          cond
          cons
          define
          else
          equal?
          if
          lambda
          let
          list
          list?
          map
          min
          pair?
          quasiquote
          quote
          set!
          string-for-each
          string-length
          string?
          substring
          unless
          unquote
          unquote-splicing
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-irregex.scm")))
    (else (include "parselynn-irregex.scm"))))
