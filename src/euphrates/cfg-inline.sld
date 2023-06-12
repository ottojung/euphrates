
(define-library
  (euphrates cfg-inline)
  (export CFG-inline)
  (import
    (only (euphrates cfg-parse-modifiers)
          CFG-parse-modifiers)
    (only (euphrates comp) comp)
    (only (euphrates hashmap)
          alist->hashmap
          hashmap-ref)
    (only (euphrates list-and-map) list-and-map)
    (only (euphrates list-map-flatten)
          list-map/flatten)
    (only (euphrates list-singleton-q)
          list-singleton?)
    (only (srfi srfi-13) string-null?)
    (only (scheme base)
          and
          begin
          car
          cdr
          cond
          cons
          define
          define-values
          else
          equal?
          if
          lambda
          let
          list
          map
          or
          set!
          string->list
          string->symbol
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/cfg-inline.scm")))
    (else (include "cfg-inline.scm"))))
