
(define-library
  (euphrates path-extension)
  (export path-extension)
  (import
    (only (srfi srfi-13)
          string-drop
          string-index-right)
    (only (scheme base)
          <
          begin
          define
          if
          let
          string-length))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/path-extension.scm")))
    (else (include "path-extension.scm"))))
