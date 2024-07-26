
(define-library
  (test-bnf-alist-calculate-follow-set)
  (import
    (only (euphrates assert-equal-hs) assert=HS))
  (import (only (euphrates assoc-or) assoc-or))
  (import
    (only (euphrates bnf-alist-calculate-follow-set)
          bnf-alist:calculate-follow-set))
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
          syntax-rules
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-bnf-alist-calculate-follow-set.scm")))
    (else (include
            "test-bnf-alist-calculate-follow-set.scm"))))
