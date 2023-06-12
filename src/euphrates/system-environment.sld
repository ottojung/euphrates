
(define-library
  (euphrates system-environment)
  (export
    system-environment-get
    system-environment-set!)
  (import
    (only (scheme base)
          begin
          char->integer
          cond-expand
          define
          if))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) getenv setenv))
           (begin
             (include-from-path
               "euphrates/system-environment.scm")))
    (else (include "system-environment.scm"))))
