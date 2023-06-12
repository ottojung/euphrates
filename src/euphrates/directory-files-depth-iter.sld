
(define-library
  (euphrates directory-files-depth-iter)
  (export directory-files-depth-iter)
  (import
    (only (euphrates append-posix-path)
          append-posix-path)
    (only (euphrates catch-any) catch-any)
    (only (euphrates define-type9) define-type9)
    (only (euphrates path-normalize) path-normalize)
    (only (euphrates queue)
          make-queue
          queue-empty?
          queue-pop!
          queue-push!)
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
          when)
    (only (scheme case-lambda) case-lambda))
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
