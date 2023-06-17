
(define-library
  (euphrates builtin-type-huh)
  (export builtin-type?)
  (import
    (only (euphrates builtin-descriptors)
          builtin-descriptors))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import
    (only (scheme base)
          assoc
          begin
          cdr
          define
          lambda
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/builtin-type-huh.scm")))
    (else (include "builtin-type-huh.scm"))))
