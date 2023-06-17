
(define-library
  (euphrates directory-files-depth-iter)
  (export directory-files-depth-iter)
  (import
    (only (euphrates append-posix-path)
          append-posix-path))
  (import (only (euphrates catch-any) catch-any))
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates path-normalize) path-normalize))
  (import
    (only (euphrates queue)
          make-queue
          queue-empty?
          queue-pop!
          queue-push!))
  (import
    (only (scheme base)
          +
          <
          =
          _
          and
          begin
          car
          cond
          cond-expand
          cons
          define
          define-syntax
          else
          eof-object?
          equal?
          if
          lambda
          length
          let
          let*
          not
          null?
          or
          quote
          set!
          string-append
          string=?
          syntax-rules
          when))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import
             (only (guile)
                   opendir
                   readdir
                   closedir
                   stat
                   stat:type))
           (begin
             (include-from-path
               "euphrates/directory-files-depth-iter.scm")))
    (else (include "directory-files-depth-iter.scm"))))
