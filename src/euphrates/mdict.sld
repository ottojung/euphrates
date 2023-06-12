
(define-library
  (euphrates mdict)
  (export
    hash->mdict
    ahash->mdict
    mdict
    mdict-has?
    mdict-set!
    mdict->alist
    mdict-keys)
  (import
    (only (euphrates hashmap)
          alist->hashmap
          hashmap->alist
          hashmap-foreach
          hashmap-has?
          hashmap-ref
          hashmap-set!
          make-hashmap)
    (only (euphrates make-unique) make-unique)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          _
          begin
          car
          cons
          define
          define-syntax
          if
          lambda
          let
          let*
          map
          quote
          syntax-rules)
    (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/mdict.scm")))
    (else (include "mdict.scm"))))
