
(define-library
  (euphrates list-singleton-q)
  (export list-singleton?)
  (import
    (only (scheme base)
          and
          begin
          cdr
          define
          not
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-singleton-q.scm")))
    (else (include "list-singleton-q.scm"))))
