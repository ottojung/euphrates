
(define-library
  (test-lesya-interpret)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort))
  (import
    (only (euphrates hashmap) hashmap->alist))
  (import
    (only (euphrates lesya-interpret)
          lesya:interpret))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (scheme base)
          =
          and
          apply
          begin
          car
          cdr
          cond
          define
          define-values
          else
          equal?
          error
          if
          lambda
          let
          list
          map
          not
          or
          quasiquote
          quote
          string<?
          unless
          unquote
          values
          when))
  (import (only (scheme eval) eval))
  (import (only (scheme process-context) exit))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-lesya-interpret.scm")))
    (else (include "test-lesya-interpret.scm"))))
