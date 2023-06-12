
(define-library
  (euphrates get-current-source-info)
  (export get-current-source-info)
  (import
    (only (scheme base)
          _
          begin
          cond-expand
          define-syntax
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) current-source-location))
           (begin
             (include-from-path
               "euphrates/get-current-source-info.scm")))
    (else (include "get-current-source-info.scm"))))
