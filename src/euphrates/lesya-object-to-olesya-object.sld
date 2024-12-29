
(define-library
  (euphrates lesya-object-to-olesya-object)
  (export lesya-object->olesya-object)
  (import
    (only (euphrates lesya-object-to-olesya-object-generic)
          lesya-object->olesya-object/generic))
  (import
    (only (scheme base) _ begin define lambda values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-object-to-olesya-object.scm")))
    (else (include "lesya-object-to-olesya-object.scm"))))
