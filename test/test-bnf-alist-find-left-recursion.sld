
(define-library
  (test-bnf-alist-find-left-recursion)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates bnf-alist-find-left-recursion)
          bnf-alist:find-left-recursion))
  (import
    (only (euphrates bnf-alist-left-recursion)
          bnf-alist:left-recursion:cycle
          bnf-alist:left-recursion:nonterminal))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base)
          _
          begin
          cadr
          car
          define
          define-syntax
          equal?
          if
          let
          let*
          list
          map
          quote
          string<?
          string=?
          syntax-rules
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-bnf-alist-find-left-recursion.scm")))
    (else (include
            "test-bnf-alist-find-left-recursion.scm"))))
