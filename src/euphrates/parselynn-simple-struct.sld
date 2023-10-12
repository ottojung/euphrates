
(define-library
  (euphrates parselynn-simple-struct)
  (export
    make-parselynn/simple-struct
    parselynn/simple-struct?
    parselynn/simple-struct:arguments
    parselynn/simple-struct:lexer
    parselynn/simple-struct:backend-parser
    parselynn/simple-struct:hidden-tree-labels
    parselynn/simple-struct:transformations)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-struct.scm")))
    (else (include "parselynn-simple-struct.scm"))))
