
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
          make-hashmap))
  (import
    (only (euphrates make-unique) make-unique))
  (import (only (euphrates raisu) raisu))
  (import
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
          syntax-rules))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/mdict.scm")))
    (else (include "mdict.scm"))))
