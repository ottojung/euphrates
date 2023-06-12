
(define-library
  (euphrates path-replace-extension)
  (export path-replace-extension)
  (import
    (only (euphrates path-without-extension)
          path-without-extension)
    (only (scheme base)
          begin
          define
          let
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/path-replace-extension.scm")))
    (else (include "path-replace-extension.scm"))))
