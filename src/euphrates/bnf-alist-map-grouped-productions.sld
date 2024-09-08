
(define-library
  (euphrates bnf-alist-map-grouped-productions)
  (export bnf-alist:map-grouped-productions)
  (import
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          lambda
          map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-map-grouped-productions.scm")))
    (else (include "bnf-alist-map-grouped-productions.scm"))))
