
(define-library
  (test-get-object-descriptor)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates get-object-descriptor)
          get-object-descriptor))
  (import (only (euphrates hashmap) make-hashmap))
  (import (only (euphrates hashset) list->hashset))
  (import
    (only (scheme base)
          assoc
          begin
          cdr
          cond-expand
          define
          quote
          string))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-get-object-descriptor.scm")))
    (else (include "test-get-object-descriptor.scm"))))
