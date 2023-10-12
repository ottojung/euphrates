
(define-library
  (euphrates parselynn-simple-extend)
  (export parselynn/simple:extend)
  (import
    (only (euphrates alist-to-keylist)
          alist->keylist))
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates assq-set-value) assq-set-value))
  (import
    (only (euphrates assq-unset-multiple-values)
          assq-unset-multiple-values))
  (import (only (euphrates fn-cons) fn-cons))
  (import
    (only (euphrates gkeyword)
          gkeyword->fkeyword
          gkeyword->rkeyword))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates keylist-to-alist)
          keylist->alist))
  (import
    (only (euphrates parselynn-simple-struct)
          parselynn/simple-struct:arguments
          parselynn/simple-struct?))
  (import
    (only (euphrates parselynn-simple)
          parselynn/simple))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          and
          append
          begin
          car
          cdr
          cond
          define
          else
          if
          let
          list
          list?
          map
          null?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-extend.scm")))
    (else (include "parselynn-simple-extend.scm"))))
