
(define-library
  (test-lesya-interpret)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates hashmap) hashmap->alist))
  (import
    (only (euphrates lesya-interpret)
          lesya:interpret))
  (import
    (only (scheme base)
          _
          apply
          begin
          car
          cdr
          cons
          define
          define-syntax
          equal?
          if
          lambda
          let
          list
          map
          pair?
          quote
          syntax-rules
          unless
          when))
  (import (only (scheme process-context) exit))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-lesya-interpret.scm")))
    (else (include "test-lesya-interpret.scm"))))
