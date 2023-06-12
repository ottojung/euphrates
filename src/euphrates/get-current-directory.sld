
(define-library
  (euphrates get-current-directory)
  (export get-current-directory)
  (import
    (only (euphrates current-directory-p)
          current-directory/p)
    (only (scheme base)
          begin
          cond-expand
          define
          let
          or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) getcwd))
           (begin
             (include-from-path
               "euphrates/get-current-directory.scm")))
    (else (include "get-current-directory.scm"))))
