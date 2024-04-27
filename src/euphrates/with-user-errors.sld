
(define-library
  (euphrates with-user-errors)
  (export with-user-errors)
  (import (only (euphrates catch-many) catch-many))
  (import
    (only (euphrates generic-error-message-key)
          generic-error:message-key))
  (import
    (only (euphrates generic-error-value-unsafe)
          generic-error:value/unsafe))
  (import
    (only (scheme base)
          _
          begin
          current-error-port
          define
          define-syntax
          lambda
          newline
          syntax-rules))
  (import (only (scheme process-context) exit))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/with-user-errors.scm")))
    (else (include "with-user-errors.scm"))))
