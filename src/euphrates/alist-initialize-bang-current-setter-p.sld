
(define-library
  (euphrates
    alist-initialize-bang-current-setter-p)
  (export alist-initialize!:current-setter/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/alist-initialize-bang-current-setter-p.scm")))
    (else (include
            "alist-initialize-bang-current-setter-p.scm"))))
