
(define-library
  (euphrates builtin-descriptors)
  (export builtin-descriptors)
  (import
    (only (euphrates atomic-box) atomic-box?)
    (only (euphrates box) box?)
    (only (scheme base)
          begin
          char?
          cond-expand
          cons
          define
          eof-object?
          equal?
          lambda
          list
          list?
          number?
          pair?
          procedure?
          quasiquote
          quote
          string
          string?
          symbol?
          unquote
          vector
          vector?
          when))
  (cond-expand
    (guile (import
             (only (guile)
                   include-from-path
                   parameter?
                   hash-table?))
           (begin
             (include-from-path
               "euphrates/builtin-descriptors.scm")))
    (else (include "builtin-descriptors.scm"))))
