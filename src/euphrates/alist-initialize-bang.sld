
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
          alist-initialize!:current-setter/p))
  (import
    (only (euphrates alist-initialize-bang-p)
          alist-initialize!/p))
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates assq-set-value) assq-set-value))
  (import
    (only (euphrates catchu-case) catchu-case))
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-clear!
          hashset-delete!
          hashset-has?
          make-hashset))
  (import (only (euphrates raisu) raisu))
  (import
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
          values))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (srfi srfi-17) setter)))
    (else (import (only (srfi 17) setter))))
  (cond-expand
    (guile (import (only (srfi srfi-31) rec)))
    (else (import (only (srfi 31) rec))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/alist-initialize-bang.scm")))
    (else (include "alist-initialize-bang.scm"))))
