
(define-library
  (euphrates dynamic-thread-mutex-make)
  (export dynamic-thread-mutex-make)
  (import
    (only (euphrates dynamic-thread-mutex-make-p-default)
          #{dynamic-thread-mutex-make#p-default}#))
  (import
    (only (euphrates dynamic-thread-mutex-make-p)
          #{dynamic-thread-mutex-make#p}#))
  (import (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-mutex-make.scm")))
    (else (include "dynamic-thread-mutex-make.scm"))))
