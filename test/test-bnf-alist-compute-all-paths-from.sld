
(define-library
  (test-bnf-alist-compute-all-paths-from)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates bnf-alist-compute-all-paths-from)
          bnf-alist:compute-all-paths-from))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort))
  (import
    (only (euphrates parselynn-epsilon)
          parselynn:epsilon))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base)
          _
          begin
          define
          define-syntax
          equal?
          let
          let*
          map
          quasiquote
          quote
          string<?
          syntax-rules
          unless
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-bnf-alist-compute-all-paths-from.scm")))
    (else (include
            "test-bnf-alist-compute-all-paths-from.scm"))))
