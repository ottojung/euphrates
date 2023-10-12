
(define-library
  (euphrates parselynn-singlechar)
  (export make-parselynn/singlechar)
  (import
    (only (euphrates apply-until-fixpoint)
          apply-until-fixpoint))
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates char-nocase-alphabetic-huh)
          char-nocase-alphabetic?))
  (import (only (euphrates comp) comp))
  (import (only (euphrates compose) compose))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-add!
          hashset-has?
          list->hashset
          make-hashset))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates labelinglogic-binding-make)
          labelinglogic::binding::make))
  (import
    (only (euphrates labelinglogic)
          labelinglogic::init))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate/reverse))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import (only (euphrates negate) negate))
  (import
    (only (euphrates parselynn-singlechar-struct)
          make-parselynn/singlechar-struct))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base)
          +
          <
          =
          and
          append
          apply
          begin
          cadr
          car
          cdr
          char?
          cond
          cons
          define
          define-values
          else
          equal?
          for-each
          if
          lambda
          let
          list
          list?
          map
          member
          not
          null?
          or
          pair?
          quasiquote
          quote
          string
          string->list
          string->symbol
          string-append
          string-length
          string-ref
          string?
          unless
          unquote
          unquote-splicing
          values
          when))
  (import
    (only (scheme char)
          char-alphabetic?
          char-lower-case?
          char-numeric?
          char-upper-case?
          char-whitespace?))
  (cond-expand
    (guile (import (only (srfi srfi-1) any filter)))
    (else (import (only (srfi 1) any filter))))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-prefix?)))
    (else (import (only (srfi 13) string-prefix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-singlechar.scm")))
    (else (include "parselynn-singlechar.scm"))))
