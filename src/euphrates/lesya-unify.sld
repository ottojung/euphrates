
(define-library
  (euphrates lesya-unify)
  (export lesya:unify)
  (import
    (only (euphrates hashmap)
          hashmap-has?
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          and
          begin
          car
          cdr
          cond
          define
          else
          equal?
          if
          length
          let
          pair?
          quote
          reverse
          symbol?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/lesya-unify.scm")))
    (else (include "lesya-unify.scm"))))
