
(define-library
  (euphrates key-value-map)
  (export key-value-map key-value-map/list)
  (import
    (only (euphrates hashmap) alist->hashmap)
    (only (scheme base)
          +
          _
          begin
          cons
          define-syntax
          list
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/key-value-map.scm")))
    (else (include "key-value-map.scm"))))
