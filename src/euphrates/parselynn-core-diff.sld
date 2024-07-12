
(define-library
  (euphrates parselynn-core-diff)
  (export parselynn:core:diff)
  (import
    (only (euphrates parselynn-core-struct)
          parselynn:core:struct:actions
          parselynn:core:struct:code
          parselynn:core:struct:driver
          parselynn:core:struct:maybefun
          parselynn:core:struct:results
          parselynn:core:struct:rules
          parselynn:core:struct:tokens))
  (import
    (only (scheme base)
          append
          apply
          begin
          define
          equal?
          if
          list
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-core-diff.scm")))
    (else (include "parselynn-core-diff.scm"))))
