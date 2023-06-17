
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
          make-hashmap))
  (import
    (only (euphrates lexical-scope-obj)
          lexical-scope-unwrap
          lexical-scope-wrap))
  (import
    (only (euphrates make-unique) make-unique))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates stack)
          stack->list
          stack-discard!
          stack-make
          stack-peek
          stack-push!))
  (import
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
          values))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/lexical-scope.scm")))
    (else (include "lexical-scope.scm"))))
