
(define-library
  (euphrates parselynn-lr-parsing-table)
  (export
    parselynn:lr-parsing-table:make
    parselynn:lr-parsing-table?
    parselynn:lr-parsing-table:state:initial
    parselynn:lr-parsing-table:state:keys
    parselynn:lr-parsing-table:state:add!
    parselynn:lr-parsing-table:action:keys
    parselynn:lr-parsing-table:action:ref
    parselynn:lr-parsing-table:action:add!
    parselynn:lr-parsing-table:goto:keys
    parselynn:lr-parsing-table:goto:ref
    parselynn:lr-parsing-table:goto:set!
    parselynn:lr-parsing-table:goto:list
    parselynn:lr-parsing-table:action:list)
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
  (import
    (only (euphrates parselynn-lr-parse-conflict)
          parselynn:lr-parse-conflict:add!
          parselynn:lr-parse-conflict:make
          parselynn:lr-parse-conflict?))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (scheme base)
          <
          _
          begin
          cond
          cons
          define
          define-syntax
          else
          equal?
          if
          lambda
          let
          list
          member
          quote
          string<?
          syntax-rules
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-parsing-table.scm")))
    (else (include "parselynn-lr-parsing-table.scm"))))
