
(define-library
  (euphrates profune-communicator)
  (export
    make-profune-communicator
    profune-communicator?
    profune-communicator-db
    profune-communicator-handle)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate/reverse))
  (import
    (only (euphrates list-map-first) list-map-first))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import
    (only (euphrates list-span-while)
          list-span-while))
  (import (only (euphrates negate) negate))
  (import
    (only (euphrates profun-CR)
          profun-CR-what
          profun-CR?))
  (import
    (only (euphrates profun-IDR)
          profun-IDR-arity
          profun-IDR-name
          profun-IDR?))
  (import
    (only (euphrates profun-RFC)
          profun-RFC-what
          profun-RFC?))
  (import
    (only (euphrates profun-abort) profun-abort-iter))
  (import
    (only (euphrates profun-database)
          profun-database-copy
          profun-database-extend
          profun-database-get
          profun-database-handle
          profun-database?))
  (import
    (only (euphrates profun-error)
          profun-error-args
          profun-error?))
  (import
    (only (euphrates profun-iterator)
          profun-iterator-copy
          profun-iterator-insert!
          profun-iterator-reset!))
  (import
    (only (euphrates profun)
          profun-iterate
          profun-next))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates stack)
          stack-empty?
          stack-make
          stack-peek
          stack-pop!
          stack-push!
          stack-unload!))
  (import
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
          values))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter reverse!)))
    (else (import (only (srfi 1) filter reverse!))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profune-communicator.scm")))
    (else (include "profune-communicator.scm"))))
