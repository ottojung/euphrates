
(define-library
  (euphrates profun-database)
  (export
    profun-database-copy
    profun-database?
    profun-database-rules
    profun-database-handler
    profun-database-falsy?
    profun-database-handle
    profun-database-get-all
    profun-database-get
    make-profun-database
    make-falsy-profun-database
    profun-database-extend)
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates hashmap)
          hashmap-copy
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates list-ref-or) list-ref-or))
  (import
    (only (euphrates profun-handler)
          profun-handler-get))
  (import
    (only (euphrates profun-rule)
          profun-rule-constructor))
  (import
    (only (euphrates profun-varname-q)
          profun-varname?))
  (import (only (euphrates usymbol) make-usymbol))
  (import
    (only (scheme base)
          +
          =
          and
          append
          begin
          car
          cdr
          cons
          define
          for-each
          if
          lambda
          length
          let
          let*
          list
          not
          null?
          or
          quasiquote
          quote
          reverse
          unquote))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-database.scm")))
    (else (include "profun-database.scm"))))
