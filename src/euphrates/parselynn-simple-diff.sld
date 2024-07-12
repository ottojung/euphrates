
(define-library
  (euphrates parselynn-simple-diff)
  (export parselynn:simple:diff)
  (import
    (only (euphrates parselynn-core-diff)
          parselynn:core:diff))
  (import
    (only (euphrates parselynn-simple-struct)
          parselynn:simple:struct:arguments
          parselynn:simple:struct:backend-parser
          parselynn:simple:struct:transformations))
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
               "euphrates/parselynn-simple-diff.scm")))
    (else (include "parselynn-simple-diff.scm"))))
