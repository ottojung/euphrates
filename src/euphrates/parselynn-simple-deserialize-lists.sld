
(define-library
  (euphrates parselynn-simple-deserialize-lists)
  (export parselynn:simple:deserialize/lists)
  (import (only (euphrates fn-cons) fn-cons))
  (import (only (euphrates hashset) list->hashset))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates parselynn-core-deserialize-lists)
          parselynn:core:deserialize/lists))
  (import
    (only (euphrates parselynn-simple-struct)
          make-parselynn:simple:struct))
  (import
    (only (euphrates zoreslava)
          zoreslava:deserialize/lists
          zoreslava:ref
          zoreslava?))
  (import
    (only (scheme base) begin define if map quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-deserialize-lists.scm")))
    (else (include
            "parselynn-simple-deserialize-lists.scm"))))
