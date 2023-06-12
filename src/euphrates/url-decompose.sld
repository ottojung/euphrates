
(define-library
  (euphrates url-decompose)
  (export url-decompose)
  (import
    (only (euphrates list-find-first)
          list-find-first)
    (only (euphrates string-split-3) string-split-3)
    (only (srfi srfi-13) string-null?)
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
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/url-decompose.scm")))
    (else (include "url-decompose.scm"))))
