
(define-library
  (euphrates parselynn-simple-extract-set)
  (export parselynn:simple:extract-set)
  (import (only (euphrates assq-or) assq-or))
  (import (only (euphrates hashset) list->hashset))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          and
          begin
          define
          list
          list?
          not
          null?
          quote
          unless
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-extract-set.scm")))
    (else (include "parselynn-simple-extract-set.scm"))))
