
(define-library
  (test-get-object-descriptor)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates get-object-descriptor)
          get-object-descriptor)
    (only (euphrates hashmap) make-hashmap)
    (only (euphrates hashset) list->hashset)
    (only (scheme base)
          assoc
          begin
          cdr
          define
          quote
          string))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-get-object-descriptor.scm")))
    (else (include "test-get-object-descriptor.scm"))))
