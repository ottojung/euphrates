
(define-library
  (euphrates parselynn-core-signal-conflict)
  (export parselynn:core:signal-conflict)
  (import
    (only (euphrates
            parselynn-core-conflict-handler-default)
          parselynn:core:conflict-handler/default))
  (import
    (only (euphrates parselynn-core-conflict-handler-p)
          parselynn:core:conflict-handler/p))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          apply
          begin
          cond
          cons
          define
          define-values
          else
          equal?
          list
          or
          quote
          values))
  (cond-expand
    (guile (import (only (srfi srfi-1) reduce)))
    (else (import (only (srfi 1) reduce))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-core-signal-conflict.scm")))
    (else (include "parselynn-core-signal-conflict.scm"))))
