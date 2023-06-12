
(define-library
  (euphrates get-current-source-file-path)
  (export get-current-source-file-path)
  (import
    (only (scheme base)
          _
          assq
          begin
          cdr
          cond-expand
          define-syntax
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/get-current-source-file-path.scm")))
    (else (include "get-current-source-file-path.scm"))))
