
(define-library
  (euphrates parselynn-ll-parse-conflict-print)
  (export parselynn:ll-parse-conflict:print)
  (import
    (only (euphrates bnf-alist-production-print)
          bnf-alist:production:print))
  (import
    (only (euphrates compose-under) compose-under))
  (import (only (euphrates compose) compose))
  (import (only (euphrates fprintf) fprintf))
  (import (only (euphrates list-init) list-init))
  (import
    (only (euphrates list-intersperse)
          list-intersperse))
  (import (only (euphrates list-last) list-last))
  (import
    (only (euphrates parselynn-ll-parse-conflict)
          parselynn:ll-parse-first-first-conflict:candidate
          parselynn:ll-parse-first-first-conflict:productions
          parselynn:ll-parse-first-first-conflict?
          parselynn:ll-parse-recursion-conflict?))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          append
          apply
          begin
          cond
          current-output-port
          define
          else
          let
          list
          map
          quote
          string-append))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-parse-conflict-print.scm")))
    (else (include "parselynn-ll-parse-conflict-print.scm"))))
