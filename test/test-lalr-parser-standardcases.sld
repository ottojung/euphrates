
(define-library
  (test-lalr-parser-standardcases)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates lalr-parser)
          lalr-parser
          lexical-token-category
          lexical-token-source
          lexical-token-value
          lexical-token?
          make-lexical-token
          make-source-location))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import
    (only (euphrates with-string-as-input)
          with-string-as-input))
  (import
    (only (scheme base)
          *
          +
          -
          /
          <
          =
          >=
          _
          and
          apply
          assoc
          begin
          cadr
          car
          cdr
          char=?
          char?
          cond
          cons
          define
          define-syntax
          else
          eof-object?
          eq?
          if
          lambda
          length
          let
          let*
          letrec
          list
          list-ref
          make-vector
          not
          or
          pair?
          peek-char
          quote
          read-char
          reverse
          set!
          string
          string->number
          symbol?
          syntax-rules
          vector
          vector-length
          vector-ref
          vector-set!
          vector?))
  (import
    (only (scheme char)
          char-alphabetic?
          char-numeric?
          char-whitespace?))
  (import (only (scheme cxr) cadar))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-lalr-parser-standardcases.scm")))
    (else (include "test-lalr-parser-standardcases.scm"))))
