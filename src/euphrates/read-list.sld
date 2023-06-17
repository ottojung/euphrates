
(define-library
  (euphrates read-list)
  (export read-list)
  (import
    (only (scheme base)
          begin
          cons
          current-input-port
          define
          eof-object?
          if
          let
          quote))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme read) read))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/read-list.scm")))
    (else (include "read-list.scm"))))
