
(define-library
  (euphrates parselynn-ll-action-print)
  (export parselynn:ll-action:print)
  (import
    (only (euphrates bnf-alist-production-lhs)
          bnf-alist:production:lhs))
  (import
    (only (euphrates bnf-alist-production-rhs)
          bnf-alist:production:rhs))
  (import (only (euphrates fprintf) fprintf))
  (import
    (only (euphrates parselynn-ll-accept-action)
          parselynn:ll-accept-action?))
  (import
    (only (euphrates parselynn-ll-choose-action)
          parselynn:ll-choose-action:production
          parselynn:ll-choose-action?))
  (import
    (only (euphrates parselynn-ll-match-action)
          parselynn:ll-match-action:symbol
          parselynn:ll-match-action?))
  (import
    (only (euphrates parselynn-ll-predict-action)
          parselynn:ll-predict-action:nonterminal
          parselynn:ll-predict-action?))
  (import
    (only (euphrates parselynn-ll-reject-action)
          parselynn:ll-reject-action?))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base)
          begin
          cond
          current-output-port
          define
          else
          let
          list
          map
          quote))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-action-print.scm")))
    (else (include "parselynn-ll-action-print.scm"))))
