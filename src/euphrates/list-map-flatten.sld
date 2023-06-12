
(define-library
  (euphrates list-map-flatten)
  (export list-map/flatten)
  (import
    (only (scheme base)
          append
          apply
          begin
          define
          map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-map-flatten.scm")))
    (else (include "list-map-flatten.scm"))))
