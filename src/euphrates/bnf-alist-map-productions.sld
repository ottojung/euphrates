
(define-library
  (euphrates bnf-alist-map-productions)
  (export bnf-alist:map-productions)
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
               "euphrates/bnf-alist-map-productions.scm")))
    (else (include "bnf-alist-map-productions.scm"))))
