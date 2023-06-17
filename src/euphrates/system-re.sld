
(define-library
  (euphrates system-re)
  (export system-re)
  (import (only (euphrates compose) compose))
  (import
    (only (euphrates file-delete) file-delete))
  (import
    (only (euphrates make-temporary-filename)
          make-temporary-filename))
  (import
    (only (euphrates read-string-file)
          read-string-file))
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
          map
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/system-re.scm")))
    (else (include "system-re.scm"))))
