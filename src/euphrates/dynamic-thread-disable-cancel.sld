
(define-library
  (euphrates dynamic-thread-disable-cancel)
  (export dynamic-thread-disable-cancel)
  (import
    (only (euphrates
            dynamic-thread-disable-cancel-p-default)
          dynamic-thread-disable-cancel/p-default))
  (import
    (only (euphrates dynamic-thread-disable-cancel-p)
          dynamic-thread-disable-cancel/p))
  (import (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-disable-cancel.scm")))
    (else (include "dynamic-thread-disable-cancel.scm"))))
