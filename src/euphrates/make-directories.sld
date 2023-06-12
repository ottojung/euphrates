
(define-library
  (euphrates make-directories)
  (export make-directories)
  (import
    (only (euphrates append-posix-path)
          append-posix-path)
    (only (euphrates file-or-directory-exists-q)
          file-or-directory-exists?)
    (only (euphrates list-fold) list-fold)
    (only (euphrates string-split-simple)
          string-split/simple)
    (only (srfi srfi-13) string-null?)
    (only (scheme base)
          begin
          cond-expand
          define
          if
          let*
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path mkdir))
           (begin
             (include-from-path
               "euphrates/make-directories.scm")))
    (else (include "make-directories.scm"))))
