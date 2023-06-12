
(define-library
  (euphrates petri-net-parse)
  (export petri-net-parse petri-lambda-net)
  (import
    (only (euphrates compose) compose)
    (only (euphrates hashmap) multi-alist->hashmap)
    (only (euphrates list-and-map) list-and-map)
    (only (euphrates petri-net-make) petri-net-make)
    (only (euphrates raisu) raisu)
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
