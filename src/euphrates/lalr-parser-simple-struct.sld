
(define-library
  (euphrates lalr-parser-simple-struct)
  (export
    make-lalr-parser/simple-struct
    lalr-parser/simple-struct?
    lalr-parser/simple-struct:arguments
    lalr-parser/simple-struct:lexer
    lalr-parser/simple-struct:backend-parser
    lalr-parser/simple-struct:hidden-tree-labels
    lalr-parser/simple-struct:transformations)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple-struct.scm")))
    (else (include "lalr-parser-simple-struct.scm"))))
