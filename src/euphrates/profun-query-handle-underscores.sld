
(define-library
  (euphrates profun-query-handle-underscores)
  (export profun-query-handle-underscores)
  (import
    (only (euphrates list-and-map) list-and-map))
  (import (only (euphrates usymbol) make-usymbol))
  (import
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
          symbol?))
  (cond-expand
    (guile (import (only (srfi srfi-1) count)))
    (else (import (only (srfi 1) count))))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-prefix?)))
    (else (import (only (srfi 13) string-prefix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-query-handle-underscores.scm")))
    (else (include "profun-query-handle-underscores.scm"))))
