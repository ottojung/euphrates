
(define-library
  (euphrates profun-env)
  (export
    make-profun-env
    profun-env-get
    profun-env-set!
    profun-env-unset!
    profun-env-copy)
  (import
    (only (euphrates hashmap)
          hashmap-copy
          hashmap-delete!
          hashmap-ref
          hashmap-set!
          make-hashmap)
    (only (euphrates profun-meta-key)
          profun-meta-key)
    (only (euphrates profun-value)
          profun-bound-value?
          profun-make-constant
          profun-make-unbound-var)
    (only (euphrates profun-varname-q)
          profun-varname?)
    (only (scheme base) begin define if))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun-env.scm")))
    (else (include "profun-env.scm"))))
