
(define-library
  (euphrates alist-to-keylist)
  (export alist->keylist)
  (import
    (only (scheme base)
          append
          begin
          car
          cdr
          define
          if
          let
          list
          null?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/alist-to-keylist.scm")))
    (else (include "alist-to-keylist.scm"))))
