
(define-library
  (euphrates dynamic-thread-enable-cancel)
  (export dynamic-thread-enable-cancel)
  (import
    (only (euphrates
            dynamic-thread-enable-cancel-p-default)
          dynamic-thread-enable-cancel/p-default))
  (import
    (only (euphrates dynamic-thread-enable-cancel-p)
          dynamic-thread-enable-cancel/p))
  (import (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-enable-cancel.scm")))
    (else (include "dynamic-thread-enable-cancel.scm"))))
