
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
          begin
          car
          cdr
          define
          define-syntax
          equal?
          if
          lambda
          let
          list
          map
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
