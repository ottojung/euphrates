
(define-library
  (euphrates cfg-machine)
  (export
    make-cfg-machine/full
    make-cfg-machine
    make-cfg-machine*)
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates immutable-hashmap)
          immutable-hashmap-foreach
          make-immutable-hashmap))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates regex-machine)
          make-regex-machine/full))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (scheme base)
          _
          and
          begin
          cadr
          call-with-values
          car
          cdr
          cons
          define
          define-values
          eq?
          for-each
          if
          lambda
          let
          list
          map
          null?
          pair?
          quote
          string-append
          unless
          values))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/cfg-machine.scm")))
    (else (include "cfg-machine.scm"))))
