
(define-library
  (euphrates alist-initialize-bang)
  (export
    alist-initialize!
    alist-initialize!:stop
    alist-initialize!:return-multiple
    alist-initialize!:get-setters
    alist-initialize!:makelet/static
    alist-initialize!:run
    alist-initialize!:current-setters)
  (import
    (only (euphrates
            alist-initialize-bang-current-setter-p)
          alist-initialize!:current-setter/p)
    (only (euphrates alist-initialize-bang-p)
          alist-initialize!/p)
    (only (euphrates assq-or) assq-or)
    (only (euphrates assq-set-value) assq-set-value)
    (only (euphrates catchu-case) catchu-case)
    (only (euphrates define-type9) define-type9)
    (only (euphrates hashset)
          hashset-add!
          hashset-clear!
          hashset-delete!
          hashset-has?
          make-hashset)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          _
          and
          assq
          begin
          car
          case
          cdr
          cons
          define
          define-syntax
          define-values
          else
          if
          lambda
          let
          let*
          letrec
          list?
          not
          null?
          or
          parameterize
          quote
          reverse
          set!
          syntax-rules
          unless
          values)
    (only (scheme case-lambda) case-lambda)
    (only (srfi srfi-1) first)
    (only (srfi srfi-17) setter)
    (only (srfi srfi-31) rec))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/alist-initialize-bang.scm")))
    (else (include "alist-initialize-bang.scm"))))
