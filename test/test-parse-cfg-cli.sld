
(define-library
  (test-parse-cfg-cli)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates parse-cfg-cli) CFG-CLI->CFG-AST))
  (import (only (scheme base) / begin quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-parse-cfg-cli.scm")))
    (else (include "test-parse-cfg-cli.scm"))))
