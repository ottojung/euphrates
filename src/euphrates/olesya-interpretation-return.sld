
(define-library
  (euphrates olesya-interpretation-return)
  (export
    olesya:return?
    olesya:return:value
    olesya:return:type
    olesya:return:ok
    olesya:return:ok?
    olesya:return:ok:value
    olesya:return:fail
    olesya:return:fail?
    olesya:return:fail:value)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import
    (only (scheme base) begin cond define else quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olesya-interpretation-return.scm")))
    (else (include "olesya-interpretation-return.scm"))))
