
(define-library
  (euphrates system-re)
  (export system-re)
  (import
    (only (euphrates compose) compose)
    (only (euphrates file-delete) file-delete)
    (only (euphrates make-temporary-filename)
          make-temporary-filename)
    (only (euphrates read-string-file)
          read-string-file)
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
          map
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/system-re.scm")))
    (else (include "system-re.scm"))))
