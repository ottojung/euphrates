
(define-library
  (euphrates parselynn-ll-parse-conflict)
  (export
    parselynn:ll-parse-conflict?
    parselynn:ll-parse-first-first-conflict:make
    parselynn:ll-parse-first-first-conflict?
    parselynn:ll-parse-first-first-conflict:candidate
    parselynn:ll-parse-first-first-conflict:productions
    parselynn:ll-parse-first-first-conflict:nonterminal
    parselynn:ll-parse-recursion-conflict:make
    parselynn:ll-parse-recursion-conflict?
    parselynn:ll-parse-recursion-conflict:nonterminal
    parselynn:ll-parse-recursion-conflict:cycle)
  (import
    (only (euphrates bnf-alist-leaf-huh)
          bnf-alist:leaf?))
  (import
    (only (euphrates bnf-alist-production-huh)
          bnf-alist:production?))
  (import
    (only (euphrates bnf-alist-production-lhs)
          bnf-alist:production:lhs))
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates define-union-type)
          define-union-type))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          begin
          car
          define
          list
          list?
          null?
          or
          quote
          unless
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-parse-conflict.scm")))
    (else (include "parselynn-ll-parse-conflict.scm"))))
