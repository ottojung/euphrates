
(define-library
  (euphrates get-current-random-source)
  (export get-current-random-source)
  (import
    (only (euphrates current-random-source-p)
          current-random-source/p))
  (import
    (only (euphrates srfi-27-generic)
          default-random-source))
  (import (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/get-current-random-source.scm")))
    (else (include "get-current-random-source.scm"))))
