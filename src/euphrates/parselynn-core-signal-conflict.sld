
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
  (import
    (only (scheme base) apply begin cons define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-core-signal-conflict.scm")))
    (else (include "parselynn-core-signal-conflict.scm"))))
