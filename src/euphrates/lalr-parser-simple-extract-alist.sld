
(define-library
  (euphrates lalr-parser-simple-extract-alist)
  (export lalr-parser/simple-extract-alist)
  (import (only (euphrates assq-or) assq-or))
  (import (only (euphrates curry-if) curry-if))
  (import (only (euphrates fn-cons) fn-cons))
  (import
    (only (euphrates hashmap) alist->hashmap))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          and
          begin
          car
          define
          list
          list?
          map
          pair?
          quote
          unless
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple-extract-alist.scm")))
    (else (include "lalr-parser-simple-extract-alist.scm"))))
