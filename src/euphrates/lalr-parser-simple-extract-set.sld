
(define-library
  (euphrates lalr-parser-simple-extract-set)
  (export lalr-parser/simple-extract-set)
  (import (only (euphrates assq-or) assq-or))
  (import (only (euphrates hashset) list->hashset))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          begin
          define
          list
          list?
          quote
          unless
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple-extract-set.scm")))
    (else (include "lalr-parser-simple-extract-set.scm"))))
