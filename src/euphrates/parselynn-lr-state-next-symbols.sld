
(define-library
  (euphrates parselynn-lr-state-next-symbols)
  (export parselynn:lr-state:next-symbols)
  (import
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-add!
          make-hashset))
  (import
    (only (euphrates parselynn-lr-item)
          parselynn:lr-item:dot-at-end?
          parselynn:lr-item:next-symbol))
  (import
    (only (euphrates parselynn-lr-state)
          parselynn:lr-state:foreach-item/nondeterministic))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (scheme base)
          begin
          define
          lambda
          let
          string<?
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-state-next-symbols.scm")))
    (else (include "parselynn-lr-state-next-symbols.scm"))))
