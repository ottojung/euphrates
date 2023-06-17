
(define-library
  (euphrates profun-answer-huh)
  (export profun-answer?)
  (import
    (only (euphrates profun-abort) profun-abort?))
  (import
    (only (euphrates profun-accept) profun-accept?))
  (import
    (only (euphrates profun-reject) profun-reject?))
  (import (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-answer-huh.scm")))
    (else (include "profun-answer-huh.scm"))))
