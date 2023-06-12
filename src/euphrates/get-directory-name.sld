
(define-library
  (euphrates get-directory-name)
  (export get-directory-name)
  (import
    (only (srfi srfi-13)
          string-every
          string-index-right
          string-null?
          string-trim-right)
    (only (scheme base)
          begin
          cond
          define
          else
          equal?
          if
          lambda
          let
          let*
          substring))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/get-directory-name.scm")))
    (else (include "get-directory-name.scm"))))
