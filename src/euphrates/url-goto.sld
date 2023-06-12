
(define-library
  (euphrates url-goto)
  (export url-goto)
  (import
    (only (euphrates path-get-dirname)
          path-get-dirname)
    (only (euphrates url-get-hostname-and-port)
          url-get-hostname-and-port)
    (only (euphrates url-get-path) url-get-path)
    (only (euphrates url-get-protocol)
          url-get-protocol)
    (only (srfi srfi-13)
          string-null?
          string-prefix?
          string-suffix?)
    (only (scheme base)
          begin
          cond
          define
          else
          if
          let*
          not
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/url-goto.scm")))
    (else (include "url-goto.scm"))))
