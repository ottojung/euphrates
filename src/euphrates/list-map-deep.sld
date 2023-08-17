
(define-library
  (euphrates list-map-deep)
  (export list-map/deep)
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          begin
          cond
          define
          else
          let
          list
          list?
          map
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-map-deep.scm")))
    (else (include "list-map-deep.scm"))))
