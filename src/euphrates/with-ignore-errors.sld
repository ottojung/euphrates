
(define-library
  (euphrates with-ignore-errors)
  (export with-ignore-errors!)
  (import (only (euphrates catch-any) catch-any))
  (import
    (only (euphrates current-source-info-to-string)
          current-source-info->string))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates get-current-source-info)
          get-current-source-info))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          lambda
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/with-ignore-errors.scm")))
    (else (include "with-ignore-errors.scm"))))
