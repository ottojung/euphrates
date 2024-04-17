
(define-library
  (euphrates parselynn-simple-extract-regexes)
  (export parselynn:simple:extract-regexes)
  (import (only (euphrates assoc-or) assoc-or))
  (import
    (only (euphrates bnf-alist-map-expansion-terms)
          bnf-alist:map-expansion-terms))
  (import
    (only (euphrates compose-under) compose-under))
  (import (only (euphrates curry-if) curry-if))
  (import (only (euphrates hashset) list->hashset))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates unique-identifier)
          make-unique-identifier
          unique-identifier?))
  (import
    (only (scheme base)
          and
          append
          apply
          begin
          car
          cdr
          cond
          cons
          define
          else
          equal?
          lambda
          list?
          map
          or
          pair?
          quote
          string?
          symbol?
          values))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-extract-regexes.scm")))
    (else (include "parselynn-simple-extract-regexes.scm"))))
