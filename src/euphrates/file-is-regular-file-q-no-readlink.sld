
(define-library
  (euphrates file-is-regular-file-q-no-readlink)
  (export file-is-regular-file?/no-readlink)
  (import
    (only (scheme base)
          and
          begin
          cond-expand
          define
          equal?
          quote)
    (only (scheme file) file-exists?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) stat stat:type))
           (begin
             (include-from-path
               "euphrates/file-is-regular-file-q-no-readlink.scm")))
    (else (include
            "file-is-regular-file-q-no-readlink.scm"))))
