
(define-library
  (euphrates current-source-info-to-string)
  (export current-source-info->string)
  (import
    (only (euphrates get-current-directory)
          get-current-directory)
    (only (euphrates remove-common-prefix)
          remove-common-prefix)
    (only (euphrates tilda-a) ~a)
    (only (scheme base)
          and
          assq
          begin
          cdr
          define
          let*
          or
          quote
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/current-source-info-to-string.scm")))
    (else (include "current-source-info-to-string.scm"))))
