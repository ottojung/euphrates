
(define-library
  (euphrates string-drop-n)
  (export string-drop-n)
  (import
    (only (scheme base)
          begin
          define
          max
          min
          string-length
          substring))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/string-drop-n.scm")))
    (else (include "string-drop-n.scm"))))
