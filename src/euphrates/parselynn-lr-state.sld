
(define-library
  (euphrates parselynn-lr-state)
  (export
    parselynn:lr-state
    parselynn:lr-state?
    parselynn:lr-state:make
    parselynn:lr-state:add!
    parselynn:lr-state:has?
    parselynn:lr-state:print
    parselynn:lr-state:foreach-item
    parselynn:lr-state:equal?)
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort))
  (import (only (euphrates fn) fn))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-add!
          hashset-foreach
          hashset-has?
          make-hashset))
  (import
    (only (euphrates parselynn-lr-item)
          parselynn:lr-item:print))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base)
          begin
          current-output-port
          define
          equal?
          lambda
          map
          parameterize
          string<?))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-state.scm")))
    (else (include "parselynn-lr-state.scm"))))
