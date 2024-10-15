
(define-library
  (euphrates olesya-reverse)
  (export olesya:reverse)
  (import (only (euphrates debug) debug))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates hashmap)
          hashmap-has?
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-has?
          make-hashset))
  (import
    (only (euphrates list-fold-semigroup)
          list-fold/semigroup))
  (import
    (only (euphrates olesya-language)
          olesya:substitution:destruct
          olesya:substitution?))
  (import
    (only (euphrates olesya-syntax)
          olesya:syntax:eval?
          olesya:syntax:let?
          olesya:syntax:rule:destruct
          olesya:syntax:rule:make
          olesya:syntax:rule?
          olesya:syntax:term?))
  (import
    (only (euphrates olesya-trace)
          olesya:trace
          olesya:trace:in-eval?
          olesya:trace:let-stack
          olesya:trace:with-callback))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          <
          begin
          cadr
          cond
          define
          define-values
          else
          equal?
          if
          lambda
          length
          let
          list
          map
          member
          not
          null?
          quote
          reverse
          unless
          values
          vector
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olesya-reverse.scm")))
    (else (include "olesya-reverse.scm"))))
