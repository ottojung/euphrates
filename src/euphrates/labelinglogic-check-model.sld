
(define-library
  (euphrates labelinglogic-check-model)
  (export labelinglogic::check-model)
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-difference
          hashset-null?
          list->hashset
          make-hashset))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import
    (only (euphrates make-unique) make-unique))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (scheme base)
          and
          assq
          begin
          car
          cond
          define
          else
          equal?
          for-each
          lambda
          let
          list
          list?
          map
          not
          null?
          or
          procedure?
          quote
          symbol?
          unless
          when))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-check-model.scm")))
    (else (include "labelinglogic-check-model.scm"))))
