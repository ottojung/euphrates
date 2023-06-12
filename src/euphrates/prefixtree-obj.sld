
(define-library
  (euphrates prefixtree-obj)
  (export
    prefixtree
    prefixtree?
    prefixtree-value
    set-prefixtree-value!
    prefixtree-children
    set-prefixtree-children!)
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/prefixtree-obj.scm")))
    (else (include "prefixtree-obj.scm"))))
