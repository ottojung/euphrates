
(define-library
  (euphrates irregex)
  (export
    irregex
    string->irregex
    sre->irregex
    string->sre
    maybe-string->sre
    irregex?
    irregex-match-data?
    irregex-new-matches
    irregex-reset-matches!
    irregex-search
    irregex-search/matches
    irregex-match
    irregex-search/chunked
    irregex-match/chunked
    make-irregex-chunker
    irregex-match-substring
    irregex-match-subchunk
    irregex-match-start-chunk
    irregex-match-start-index
    irregex-match-end-chunk
    irregex-match-end-index
    irregex-match-num-submatches
    irregex-match-names
    irregex-match-valid-index?
    irregex-fold
    irregex-replace
    irregex-replace/all
    irregex-dfa
    irregex-dfa/search
    irregex-nfa
    irregex-flags
    irregex-lengths
    irregex-names
    irregex-num-submatches
    irregex-extract
    irregex-split)
  (import (only (euphrates range) range))
  (import
    (only (scheme base)
          *
          +
          -
          /
          <
          <=
          =
          =>
          >
          >=
          _
          and
          append
          apply
          assoc
          assq
          assv
          begin
          caar
          cadr
          car
          case
          cdar
          cddr
          cdr
          char->integer
          char<=?
          char<?
          char=?
          char>=?
          char>?
          char?
          cond
          cons
          define
          do
          else
          eq?
          equal?
          eqv?
          error
          exact?
          expt
          for-each
          if
          integer->char
          integer?
          lambda
          length
          let
          let*
          letrec
          list
          list->vector
          make-string
          make-vector
          map
          max
          memq
          memv
          min
          modulo
          newline
          not
          null?
          number->string
          number?
          odd?
          or
          pair?
          procedure?
          quasiquote
          quote
          quotient
          reverse
          set!
          set-car!
          string
          string->list
          string->number
          string->symbol
          string-append
          string-length
          string-ref
          string-set!
          string=?
          string?
          substring
          symbol->string
          symbol?
          unquote
          unquote-splicing
          vector
          vector->list
          vector-copy
          vector-length
          vector-ref
          vector-set!
          vector?
          zero?))
  (import
    (only (scheme char)
          char-alphabetic?
          char-ci=?
          char-downcase
          char-numeric?
          char-upcase
          char-upper-case?
          char-whitespace?
          string-ci=?))
  (import
    (only (scheme cxr)
          cadadr
          cadar
          caddar
          cadddr
          caddr
          cddadr
          cddar
          cdddr))
  (import (only (scheme read) read))
  (cond-expand
    (guile (import
             (only (srfi srfi-1)
                   any
                   count
                   every
                   filter
                   find
                   find-tail
                   first
                   fold
                   last
                   remove)))
    (else (import
            (only (srfi 1)
                  any
                  count
                  every
                  filter
                  find
                  find-tail
                  first
                  fold
                  last
                  remove))))
  (cond-expand
    (guile (import (only (srfi srfi-31) rec)))
    (else (import (only (srfi 31) rec))))
  (cond-expand
    (guile (import (only (srfi srfi-42) :)))
    (else (import (only (srfi 42) :))))
  (cond-expand
    (guile (import (only (srfi srfi-67) =? >=?)))
    (else (import (only (srfi 67) =? >=?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/irregex.scm")))
    (else (include "irregex.scm"))))
