
(define-library
  (euphrates dynamic-thread-spawn)
  (export dynamic-thread-spawn)
  (import
    (only (euphrates dynamic-thread-spawn-p)
          #{dynamic-thread-spawn#p}#)
    (only (euphrates raisu) raisu)
    (only (scheme base) begin define or quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-spawn.scm")))
    (else (include "dynamic-thread-spawn.scm"))))
