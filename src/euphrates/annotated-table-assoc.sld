
(define-library
  (euphrates annotated-table-assoc)
  (export annotated-table-assoc)
  (import
    (only (euphrates list-find-element-index)
          list-find-element-index))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          +
          begin
          car
          cdr
          define
          let
          list
          list-ref
          map
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/annotated-table-assoc.scm")))
    (else (include "annotated-table-assoc.scm"))))
