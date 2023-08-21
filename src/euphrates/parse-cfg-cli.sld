
(define-library
  (euphrates parse-cfg-cli)
  (export CFG-CLI->CFG-AST)
  (import
    (only (euphrates generic-bnf-tree-to-alist)
          generic-bnf-tree->alist))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          /
          begin
          cons
          define
          list
          null?
          quote
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/parse-cfg-cli.scm")))
    (else (include "parse-cfg-cli.scm"))))
