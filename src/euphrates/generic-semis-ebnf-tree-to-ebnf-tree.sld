
(define-library
  (euphrates generic-semis-ebnf-tree-to-ebnf-tree)
  (export generic-semis-ebnf-tree->ebnf-tree)
  (import (only (euphrates curry-if) curry-if))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base)
          *
          +
          -
          and
          begin
          car
          cdr
          cond
          cons
          define
          else
          equal?
          lambda
          let
          list
          map
          not
          null?
          quote
          string->symbol
          string-length
          substring
          symbol?))
  (cond-expand
    (guile (import
             (only (srfi srfi-13)
                   string-prefix?
                   string-suffix?)))
    (else (import
            (only (srfi 13) string-prefix? string-suffix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-semis-ebnf-tree-to-ebnf-tree.scm")))
    (else (include
            "generic-semis-ebnf-tree-to-ebnf-tree.scm"))))
