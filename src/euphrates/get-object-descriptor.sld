
(define-library
  (euphrates get-object-descriptor)
  (export get-object-descriptor)
  (import
    (only (euphrates builtin-descriptors)
          builtin-descriptors)
    (only (euphrates define-type9)
          type9-get-record-descriptor)
    (only (euphrates list-map-first) list-map-first)
    (only (scheme base)
          and
          assoc
          begin
          cdr
          define
          lambda
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/get-object-descriptor.scm")))
    (else (include "get-object-descriptor.scm"))))
