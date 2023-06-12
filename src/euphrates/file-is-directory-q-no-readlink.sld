
(define-library
  (euphrates file-is-directory-q-no-readlink)
  (export file-is-directory?/no-readlink)
  (import
    (only (scheme base)
          and
          begin
          cond-expand
          define
          equal?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) stat stat:type))
           (begin
             (include-from-path
               "euphrates/file-is-directory-q-no-readlink.scm")))
    (else (include "file-is-directory-q-no-readlink.scm"))))
