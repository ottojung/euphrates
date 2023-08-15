
(define-library
  (euphrates generic-error-huh)
  (export generic-error?)
  (import
    (only (euphrates generic-error-self-key)
          generic-error:self-key))
  (import
    (only (euphrates hashmap) hashmap-has? hashmap?))
  (import (only (euphrates list-last) list-last))
  (import
    (only (scheme base)
          and
          begin
          define
          error-object-irritants
          error-object?
          let*
          not
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-error-huh.scm")))
    (else (include "generic-error-huh.scm"))))
