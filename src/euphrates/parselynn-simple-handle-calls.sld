
(define-library
  (euphrates parselynn-simple-handle-calls)
  (export parselynn:simple:handle-calls)
  (import
    (only (euphrates bnf-alist-map-productions-star)
          bnf-alist:map-productions*))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          and
          begin
          cadr
          car
          cdr
          define
          equal?
          if
          lambda
          let
          list
          null?
          pair?
          quote
          reverse
          unless
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) last)))
    (else (import (only (srfi 1) last))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-handle-calls.scm")))
    (else (include "parselynn-simple-handle-calls.scm"))))
