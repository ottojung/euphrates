
(define-library
  (euphrates keylist-to-alist)
  (export keylist->alist)
  (import (only (euphrates fkeyword) fkeyword?))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates rkeyword) rkeyword?))
  (import
    (only (scheme base)
          +
          begin
          car
          cdr
          cons
          define
          if
          let
          list
          list?
          null?
          or
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/keylist-to-alist.scm")))
    (else (include "keylist-to-alist.scm"))))
