
(define-library
  (test-immutable-hashmap)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates immutable-hashmap)
          immutable-hashmap-ref
          immutable-hashmap-set
          make-immutable-hashmap))
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-immutable-hashmap.scm")))
    (else (include "test-immutable-hashmap.scm"))))
