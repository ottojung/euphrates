
(define-library
  (euphrates olesya-unify)
  (export olesya:unify)
  (import
    (only (euphrates hashmap)
          hashmap-has?
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates olesya-syntax)
          olesya:syntax:rule:make))
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
          quote
          reverse
          symbol?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olesya-unify.scm")))
    (else (include "olesya-unify.scm"))))
