
(define-library
  (euphrates parselynn-lr-item-next-lookaheads)
  (export parselynn:lr-item:next-lookaheads)
  (import
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort))
  (import (only (euphrates hashmap) hashmap-ref))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-has?))
  (import
    (only (euphrates parselynn-end-of-input)
          parselynn:end-of-input))
  (import
    (only (euphrates parselynn-epsilon)
          parselynn:epsilon))
  (import
    (only (euphrates parselynn-lr-item)
          parselynn:lr-item:after-dot
          parselynn:lr-item:lookahead))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (scheme base)
          append
          begin
          car
          cdr
          cond
          define
          else
          equal?
          if
          lambda
          let
          list
          null?
          quote
          string<?))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-item-next-lookaheads.scm")))
    (else (include "parselynn-lr-item-next-lookaheads.scm"))))
