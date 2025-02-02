
(define-library
  (euphrates parselynn-hashmap-ref-epsilon-aware)
  (export parselynn:hashmap-ref/epsilon-aware)
  (import (only (euphrates hashmap) hashmap-ref))
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-foreach
          hashset-has?
          hashset?
          make-hashset))
  (import
    (only (euphrates list-find-first)
          list-find-first))
  (import
    (only (euphrates parselynn-end-of-input)
          parselynn:end-of-input))
  (import
    (only (euphrates parselynn-epsilon)
          parselynn:epsilon))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import
    (only (scheme base)
          begin
          car
          cond
          define
          else
          equal?
          let
          not
          quote
          set!
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-hashmap-ref-epsilon-aware.scm")))
    (else (include
            "parselynn-hashmap-ref-epsilon-aware.scm"))))
