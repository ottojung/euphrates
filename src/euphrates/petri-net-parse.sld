
(define-library
  (euphrates petri-net-parse)
  (export petri-net-parse petri-lambda-net)
  (import (only (euphrates compose) compose))
  (import
    (only (euphrates hashmap) multi-alist->hashmap))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates petri-net-make) petri-net-make))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          <=
          =
          and
          begin
          cadr
          car
          cdr
          cons
          define
          integer?
          lambda
          length
          let
          list?
          map
          pair?
          procedure?
          quote
          symbol?
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/petri-net-parse.scm")))
    (else (include "petri-net-parse.scm"))))
