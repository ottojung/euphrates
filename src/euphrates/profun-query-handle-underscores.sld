
(define-library
  (euphrates profun-query-handle-underscores)
  (export profun-query-handle-underscores)
  (import
    (only (euphrates list-and-map) list-and-map)
    (only (euphrates usymbol) make-usymbol)
    (only (srfi srfi-13) string-prefix?)
    (only (scheme base)
          +
          =
          _
          begin
          cond
          cons
          define
          else
          if
          lambda
          let
          list?
          map
          not
          quote
          set!
          string-length
          symbol->string
          symbol?)
    (only (srfi srfi-1) count))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-query-handle-underscores.scm")))
    (else (include "profun-query-handle-underscores.scm"))))
