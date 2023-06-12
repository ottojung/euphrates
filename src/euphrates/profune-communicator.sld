
(define-library
  (euphrates profune-communicator)
  (export
    make-profune-communicator
    profune-communicator?
    profune-communicator-db
    profune-communicator-handle)
  (import
    (only (euphrates define-type9) define-type9)
    (only (euphrates identity) identity)
    (only (euphrates list-and-map) list-and-map)
    (only (euphrates list-deduplicate)
          list-deduplicate/reverse)
    (only (euphrates list-map-first) list-map-first)
    (only (euphrates list-singleton-q)
          list-singleton?)
    (only (euphrates list-span-while)
          list-span-while)
    (only (euphrates negate) negate)
    (only (euphrates profun-CR)
          profun-CR-what
          profun-CR?)
    (only (euphrates profun-IDR)
          profun-IDR-arity
          profun-IDR-name
          profun-IDR?)
    (only (euphrates profun-RFC)
          profun-RFC-what
          profun-RFC?)
    (only (euphrates profun-abort) profun-abort-iter)
    (only (euphrates profun-database)
          profun-database-copy
          profun-database-extend
          profun-database-get
          profun-database-handle
          profun-database?)
    (only (euphrates profun-error)
          profun-error-args
          profun-error?)
    (only (euphrates profun-iterator)
          profun-iterator-copy
          profun-iterator-insert!
          profun-iterator-reset!)
    (only (euphrates profun)
          profun-iterate
          profun-next)
    (only (euphrates raisu) raisu)
    (only (euphrates stack)
          stack-empty?
          stack-make
          stack-peek
          stack-pop!
          stack-push!
          stack-unload!)
    (only (scheme base)
          +
          <=
          =
          >=
          and
          begin
          car
          case
          cdr
          cond
          cons
          define
          define-values
          else
          equal?
          error
          if
          integer?
          lambda
          length
          let
          list
          list?
          map
          not
          null?
          number?
          or
          pair?
          quasiquote
          quote
          symbol?
          unquote
          unquote-splicing
          values)
    (only (srfi srfi-1) filter reverse!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profune-communicator.scm")))
    (else (include "profune-communicator.scm"))))
