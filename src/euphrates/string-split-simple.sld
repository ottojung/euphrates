
(define-library
  (euphrates string-split-simple)
  (export string-split/simple)
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          begin
          char?
          cond
          cond-expand
          define
          else
          if
          quote
          string))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-null?)))
    (else (import (only (srfi 13) string-null?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) string-split))
           (begin
             (include-from-path
               "euphrates/string-split-simple.scm")))
    (racket
      (import (only (racket) string-split))
      (include "string-split-simple.racket.scm"))
    (else (import (only (srfi 130) string-split))
          (include "string-split-simple.scm"))))
