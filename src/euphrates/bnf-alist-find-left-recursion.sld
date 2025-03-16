
(define-library
  (euphrates bnf-alist-find-left-recursion)
  (export bnf-alist:find-left-recursion)
  (import
    (only (euphrates bnf-alist-compute-all-paths-from)
          bnf-alist:compute-all-paths-from))
  (import
    (only (euphrates bnf-alist-compute-reachability)
          bnf-alist:compute-reachability))
  (import
    (only (euphrates bnf-alist-left-recursion)
          bnf-alist:left-recursion:make))
  (import
    (only (euphrates bnf-alist-nonterminals)
          bnf-alist:nonterminals))
  (import (only (euphrates hashmap) hashmap-ref))
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (euphrates list-map-flatten)
          list-map/flatten))
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          map
          member))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-find-left-recursion.scm")))
    (else (include "bnf-alist-find-left-recursion.scm"))))
