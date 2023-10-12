
(define-library
  (euphrates parselynn-simple-extract-regexes)
  (export parselynn/simple-extract-regexes)
  (import
    (only (euphrates bnf-alist-map-expansion-terms)
          bnf-alist:map-expansion-terms))
  (import
    (only (euphrates compose-under) compose-under))
  (import (only (euphrates curry-if) curry-if))
  (import (only (euphrates hashset) list->hashset))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-collapse) list-collapse))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate))
  (import (only (euphrates list-fold) list-fold))
  (import
    (only (euphrates list-intersperse)
          list-intersperse))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          +
          =
          and
          append
          apply
          begin
          car
          cdr
          cond
          cons
          define
          define-values
          else
          equal?
          if
          let
          list?
          map
          or
          pair?
          quote
          string->symbol
          string-append
          string?
          values))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-prefix?)))
    (else (import (only (srfi 13) string-prefix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-extract-regexes.scm")))
    (else (include
            "parselynn-simple-extract-regexes.scm"))))
