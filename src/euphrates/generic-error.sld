
(define-library
  (euphrates generic-error)
  (export generic-error)
  (import
    (only (euphrates alist-to-hashmap-native)
          alist->hashmap/native))
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates generic-error-irritants-key)
          generic-error:irritants-key))
  (import
    (only (euphrates generic-error-malformed-key)
          generic-error:malformed-key))
  (import
    (only (euphrates generic-error-message-key)
          generic-error:message-key))
  (import
    (only (euphrates generic-error-self-key)
          generic-error:self-key))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (scheme base)
          and
          append
          apply
          begin
          cons
          define
          error
          if
          list
          list?
          pair?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/generic-error.scm")))
    (else (include "generic-error.scm"))))
