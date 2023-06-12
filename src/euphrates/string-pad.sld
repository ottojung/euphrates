
(define-library
  (euphrates string-pad)
  (export string-pad-L string-pad-R)
  (import
    (only (euphrates replicate) replicate)
    (only (scheme base)
          -
          >=
          append
          begin
          define
          if
          let*
          list->string
          string->list
          string-length))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/string-pad.scm")))
    (else (include "string-pad.scm"))))
