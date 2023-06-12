
(define-library
  (euphrates remove-common-prefix)
  (export remove-common-prefix)
  (import
    (only (euphrates list-remove-common-prefix)
          list-remove-common-prefix)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          begin
          cond
          define
          else
          list->string
          list?
          quote
          string->list
          string?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/remove-common-prefix.scm")))
    (else (include "remove-common-prefix.scm"))))
