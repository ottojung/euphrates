
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
          make-hashmap))
  (import
    (only (euphrates profun-meta-key)
          profun-meta-key))
  (import
    (only (euphrates profun-value)
          profun-bound-value?
          profun-make-constant
          profun-make-unbound-var))
  (import
    (only (euphrates profun-varname-q)
          profun-varname?))
  (import (only (scheme base) begin define if))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun-env.scm")))
    (else (include "profun-env.scm"))))
