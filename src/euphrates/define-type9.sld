
(define-library
  (euphrates define-type9)
  (export
    define-type9
    define-type9/nobind-descriptor
    type9-get-record-descriptor
    type9-get-descriptor-by-name)
  (import
    (only (euphrates define-dumb-record)
          define-dumb-record)
    (only (euphrates descriptors-registry)
          descriptors-registry-add!
          descriptors-registry-decolisify-name
          descriptors-registry-get)
    (only (euphrates raisu) raisu)
    (only (euphrates range) range)
    (only (scheme base)
          +
          <
          =
          _
          and
          append
          apply
          begin
          cdr
          cons
          define
          define-syntax
          define-values
          equal?
          if
          lambda
          length
          let
          let*
          list
          list-ref
          map
          not
          null?
          or
          quasiquote
          quote
          reverse
          syntax-rules
          unless
          unquote
          values
          vector
          vector-length
          vector-ref)
    (only (srfi srfi-1) filter)
    (only (srfi srfi-42) :))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/define-type9.scm")))
    (else (include "define-type9.scm"))))
