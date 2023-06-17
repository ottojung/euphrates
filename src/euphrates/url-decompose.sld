
(define-library
  (euphrates url-decompose)
  (export url-decompose)
  (import
    (only (euphrates list-find-first)
          list-find-first))
  (import
    (only (euphrates string-split-3) string-split-3))
  (import
    (only (scheme base)
          begin
          case
          define
          define-values
          else
          equal?
          if
          lambda
          or
          string->list
          string-append
          values))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-null?)))
    (else (import (only (srfi 13) string-null?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/url-decompose.scm")))
    (else (include "url-decompose.scm"))))
