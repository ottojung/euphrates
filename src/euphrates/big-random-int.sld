
(define-library
  (euphrates big-random-int)
  (export big-random-int)
  (import
    (only (euphrates get-current-random-source)
          get-current-random-source))
  (import
    (only (euphrates srfi-27-generic)
          random-source-make-integers))
  (import
    (only (scheme base) begin define lambda max))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/big-random-int.scm")))
    (else (include "big-random-int.scm"))))
