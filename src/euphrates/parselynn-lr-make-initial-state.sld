
(define-library
  (euphrates parselynn-lr-make-initial-state)
  (export
    parselynn:lr-make-initial-state
    parselynn:lr-make-initial-state/given-first)
  (import
    (only (euphrates bnf-alist-assoc-productions)
          bnf-alist:assoc-productions))
  (import
    (only (euphrates bnf-alist-compute-first-set)
          bnf-alist:compute-first-set))
  (import
    (only (euphrates bnf-alist-start-symbol)
          bnf-alist:start-symbol))
  (import
    (only (euphrates parselynn-end-of-input)
          parselynn:end-of-input))
  (import
    (only (euphrates parselynn-lr-closure)
          parselynn:lr-state:close!/given-first))
  (import
    (only (euphrates parselynn-lr-item)
          parselynn:lr-item:make))
  (import
    (only (euphrates parselynn-lr-state)
          parselynn:lr-state:add!
          parselynn:lr-state:make))
  (import
    (only (scheme base)
          begin
          define
          for-each
          lambda
          let
          null?
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-make-initial-state.scm")))
    (else (include "parselynn-lr-make-initial-state.scm"))))
