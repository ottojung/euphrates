
(define-library
  (euphrates alist-to-hashmap-native)
  (export alist->hashmap/native)
  (import
    (only (scheme base) begin cond-expand define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import
             (only (ice-9 hash-table) alist->hash-table))
           (begin
             (include-from-path
               "euphrates/alist-to-hashmap-native.scm")))
    (else (include "alist-to-hashmap-native.scm"))))
