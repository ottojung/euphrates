
(define-library
  (euphrates tree-map-leafs)
  (export tree-map-leafs)
  (import (only (euphrates fn) fn))
  (import
    (only (scheme base)
          begin
          define
          if
          let
          list?
          map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/tree-map-leafs.scm")))
    (else (include "tree-map-leafs.scm"))))
