
(define-library
  (euphrates parselynn-lr-item)
  (export
    parselynn:lr-item
    parselynn:lr-item?
    parselynn:lr-item:make
    parselynn:lr-item:left-hand-side
    parselynn:lr-item:dot-position
    parselynn:lr-item:right-hand-side
    parselynn:lr-item:lookahead
    parselynn:lr-item:dot-at-end?
    parselynn:lr-item:next-symbol
    parselynn:lr-item:advance
    parselynn:lr-item:before-dot
    parselynn:lr-item:after-dot
    parselynn:lr-item:print)
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates list-drop-n) list-drop-n))
  (import
    (only (euphrates list-take-n) list-take-n))
  (import
    (only (euphrates object-to-string)
          object->string))
  (import
    (only (euphrates parselynn-epsilon)
          parselynn:epsilon))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          +
          >=
          begin
          current-output-port
          define
          equal?
          for-each
          if
          length
          list
          list-ref
          parameterize
          quote))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-item.scm")))
    (else (include "parselynn-lr-item.scm"))))
