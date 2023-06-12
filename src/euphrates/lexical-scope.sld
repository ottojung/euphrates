
(define-library
  (euphrates lexical-scope)
  (export
    lexical-scope-make
    lexical-scope-set!
    lexical-scope-ref
    lexical-scope-stage!
    lexical-scope-unstage!
    lexical-scope-namespace)
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap)
    (only (euphrates lexical-scope-obj)
          lexical-scope-unwrap
          lexical-scope-wrap)
    (only (euphrates make-unique) make-unique)
    (only (euphrates raisu) raisu)
    (only (euphrates stack)
          stack->list
          stack-discard!
          stack-make
          stack-peek
          stack-push!)
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          eq?
          equal?
          if
          let
          null?
          quote
          values)
    (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/lexical-scope.scm")))
    (else (include "lexical-scope.scm"))))
