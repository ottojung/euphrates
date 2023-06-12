
(define-library
  (test-prefixtree)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates prefixtree)
          make-prefixtree
          prefixtree->tree
          prefixtree-ref
          prefixtree-ref-closest
          prefixtree-ref-furthest
          prefixtree-set!)
    (only (scheme base) begin define let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-prefixtree.scm")))
    (else (include "test-prefixtree.scm"))))
