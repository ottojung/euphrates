
(define-library
  (euphrates directory-tree)
  (export directory-tree)
  (import
    (only (scheme base)
          begin
          car
          cddr
          cond-expand
          cons
          define
          if
          let
          map
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (ice-9 ftw))
           (begin
             (include-from-path
               "euphrates/directory-tree.scm")))
    (else (include "directory-tree.scm"))))
