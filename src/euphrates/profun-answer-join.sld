
(define-library
  (euphrates profun-answer-join)
  (export
    profun-answer-join/any
    profun-answer-join/or
    profun-answer-join/and)
  (import
    (only (euphrates hashmap)
          alist->hashmap
          hashmap->alist))
  (import
    (only (euphrates profun-abort) profun-abort?))
  (import
    (only (euphrates profun-accept)
          make-profun-accept
          profun-accept-alist
          profun-accept-ctx
          profun-accept-ctx-changed?
          profun-accept?))
  (import
    (only (euphrates profun-reject) profun-reject?))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          append
          begin
          cond
          define
          else
          if
          let*
          or
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-answer-join.scm")))
    (else (include "profun-answer-join.scm"))))
