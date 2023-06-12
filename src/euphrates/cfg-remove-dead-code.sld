
(define-library
  (euphrates cfg-remove-dead-code)
  (export CFG-remove-dead-code)
  (import
    (only (euphrates cfg-strip-modifiers)
          CFG-strip-modifiers)
    (only (euphrates hashmap)
          alist->hashmap
          hashmap-ref)
    (only (euphrates hashset)
          hashset-add!
          hashset-has?
          make-hashset)
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          for-each
          if
          lambda
          let
          null?
          string->symbol
          unless
          when)
    (only (srfi srfi-1) filter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/cfg-remove-dead-code.scm")))
    (else (include "cfg-remove-dead-code.scm"))))
