
(define-library
  (test-bnf-alist-calculate-first-set)
  (import
    (only (euphrates assert-equal-hs) assert=HS))
  (import (only (euphrates assoc-or) assoc-or))
  (import
    (only (euphrates bnf-alist-calculate-first-set)
          bnf-alist:calculate-first-set))
  (import
    (only (euphrates hashmap) hashmap->alist))
  (import (only (euphrates hashset) hashset->list))
  (import
    (only (scheme base)
          *
          +
          _
          begin
          car
          define
          define-syntax
          for-each
          lambda
          let
          map
          quasiquote
          quote
          string->symbol
          syntax-rules
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-bnf-alist-calculate-first-set.scm")))
    (else (include
            "test-bnf-alist-calculate-first-set.scm"))))
