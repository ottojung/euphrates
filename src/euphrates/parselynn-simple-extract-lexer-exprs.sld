
(define-library
  (euphrates parselynn-simple-extract-lexer-exprs)
  (export parselynn:simple:extract-lexer-exprs)
  (import (only (euphrates assoc-or) assoc-or))
  (import
    (only (euphrates bnf-alist-map-expansion-terms)
          bnf-alist:map-expansion-terms))
  (import
    (only (euphrates compose-under) compose-under))
  (import (only (euphrates curry-if) curry-if))
  (import (only (euphrates hashset) list->hashset))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate))
  (import
    (only (euphrates parselynn-folexer-expression-head-huh)
          parselynn:folexer:expression:head?))
  (import
    (only (euphrates unique-identifier)
          make-unique-identifier))
  (import
    (only (scheme base)
          append
          apply
          begin
          car
          cdr
          cons
          define
          lambda
          map
          symbol?
          values))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-extract-lexer-exprs.scm")))
    (else (include "parselynn-simple-extract-lexer-exprs.scm"))))
