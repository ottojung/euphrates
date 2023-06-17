
(define-library
  (euphrates
    dynamic-thread-get-delay-procedure-p-default)
  (export
    #{dynamic-thread-get-delay-procedure#p-default}#)
  (import
    (only (euphrates dynamic-thread-get-wait-delay)
          dynamic-thread-get-wait-delay))
  (import
    (only (euphrates dynamic-thread-sleep-p)
          #{dynamic-thread-sleep#p}#))
  (import
    (only (euphrates dynamic-thread-sleep)
          dynamic-thread-sleep))
  (import
    (only (scheme base) _ begin define lambda let or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-get-delay-procedure-p-default.scm")))
    (else (include
            "dynamic-thread-get-delay-procedure-p-default.scm"))))
