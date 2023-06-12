
(define-library
  (euphrates system-fmt)
  (export system-fmt)
  (import
    (only (euphrates compose) compose)
    (only (euphrates shell-quote-permissive)
          shell-quote/permissive)
    (only (euphrates stringf) stringf)
    (only (euphrates system-star-exit-code)
          system*/exit-code)
    (only (euphrates tilda-a) ~a)
    (only (scheme base)
          apply
          begin
          cons
          define
          let*
          map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/system-fmt.scm")))
    (else (include "system-fmt.scm"))))
