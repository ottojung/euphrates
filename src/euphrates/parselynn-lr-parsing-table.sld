
(define-library
  (euphrates parselynn-lr-parsing-table)
  (export
    parselynn:lr-parsing-table:make
    parselynn:lr-parsing-table?
    parselynn:lr-parsing-table:state:keys
    parselynn:lr-parsing-table:state:add!
    parselynn:lr-parsing-table:action:keys
    parselynn:lr-parsing-table:action:ref
    parselynn:lr-parsing-table:action:add!
    parselynn:lr-parsing-table:goto:keys
    parselynn:lr-parsing-table:goto:ref
    parselynn:lr-parsing-table:goto:set!
    parselynn:lr-parsing-table:goto:list)
  (import (only (euphrates assoc-or) assoc-or))
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-add!
          make-hashset))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (scheme base)
          <
          _
          begin
          car
          cons
          define
          define-syntax
          if
          lambda
          let
          list
          map
          member
          or
          quote
          string<?
          syntax-rules
          unless
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-parsing-table.scm")))
    (else (include "parselynn-lr-parsing-table.scm"))))
