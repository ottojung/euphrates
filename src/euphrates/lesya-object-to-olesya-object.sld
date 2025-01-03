
(define-library
  (euphrates lesya-object-to-olesya-object)
  (export lesya-object->olesya-object)
  (import
    (only (euphrates lesya-axiom-to-olesya-object)
          lesya-axiom->olesya-object))
  (import
    (only (euphrates olesya-interpretation-return)
          olesya:return:map
          olesya:return:ok?))
  (import
    (only (scheme base) begin cond define else))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-object-to-olesya-object.scm")))
    (else (include "lesya-object-to-olesya-object.scm"))))
