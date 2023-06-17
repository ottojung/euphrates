
(define-library
  (euphrates string-trim-chars)
  (export string-trim-chars)
  (import
    (only (scheme base)
          begin
          case
          define
          if
          memv
          string->list
          string?))
  (cond-expand
    (guile (import
             (only (srfi srfi-13)
                   string-trim
                   string-trim-both
                   string-trim-right)))
    (else (import
            (only (srfi 13)
                  string-trim
                  string-trim-both
                  string-trim-right))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/string-trim-chars.scm")))
    (else (include "string-trim-chars.scm"))))
