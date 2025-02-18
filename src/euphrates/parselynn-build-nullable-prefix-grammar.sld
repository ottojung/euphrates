
(define-library
  (euphrates
    parselynn-build-nullable-prefix-grammar)
  (export parselynn:build-nullable-prefix-grammar)
  (import
    (only (euphrates bnf-alist-compute-first-set)
          bnf-alist:compute-first-set))
  (import
    (only (euphrates bnf-alist-for-each-production)
          bnf-alist:for-each-production))
  (import (only (euphrates comp) comp))
  (import (only (euphrates fn-cons) fn-cons))
  (import (only (euphrates hashmap) hashmap-ref))
  (import (only (euphrates hashset) hashset-has?))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-take-until)
          list-take-until))
  (import
    (only (euphrates parselynn-epsilon)
          parselynn:epsilon))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          and
          begin
          cons
          define
          for-each
          lambda
          map
          not
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-build-nullable-prefix-grammar.scm")))
    (else (include
            "parselynn-build-nullable-prefix-grammar.scm"))))
