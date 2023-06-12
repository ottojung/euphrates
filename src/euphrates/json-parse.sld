
(define-library
  (euphrates json-parse)
  (export json-parse)
  (import
    (only (euphrates raisu) raisu)
    (only (scheme base)
          *
          +
          /
          <
          <=
          =
          >=
          and
          begin
          case
          char->integer
          cond
          cons
          define
          else
          eof-object?
          eqv?
          expt
          if
          integer->char
          length
          let
          let*
          list
          list->string
          list->vector
          not
          or
          peek-char
          quote
          read-char
          reverse
          string-length
          string-ref
          values
          when
          zero?)
    (only (scheme char) char-whitespace?)
    (only (scheme r5rs) exact->inexact))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/json-parse.scm")))
    (else (include "json-parse.scm"))))
