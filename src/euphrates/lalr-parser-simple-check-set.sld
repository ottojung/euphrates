
(define-library
  (euphrates lalr-parser-simple-check-set)
  (export lalr-parser/simple-check-set)
  (import (only (euphrates compose) compose))
  (import (only (euphrates hashset) hashset->list))
  (import (only (euphrates negate) negate))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base)
          begin
          define
          lambda
          list
          map
          memq
          null?
          quote
          unless))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple-check-set.scm")))
    (else (include "lalr-parser-simple-check-set.scm"))))
