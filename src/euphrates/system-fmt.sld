
(define-library
  (euphrates system-fmt)
  (export system-fmt)
  (import (only (euphrates compose) compose))
  (import
    (only (euphrates shell-quote-permissive)
          shell-quote/permissive))
  (import (only (euphrates stringf) stringf))
  (import
    (only (euphrates system-star-exit-code)
          system*/exit-code))
  (import (only (euphrates tilda-a) ~a))
  (import
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
