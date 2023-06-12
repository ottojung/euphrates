
(define-library
  (euphrates absolute-posix-path-q)
  (export absolute-posix-path?)
  (import
    (only (scheme base)
          >
          and
          begin
          char=?
          define
          string-length
          string-ref
          string?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/absolute-posix-path-q.scm")))
    (else (include "absolute-posix-path-q.scm"))))
