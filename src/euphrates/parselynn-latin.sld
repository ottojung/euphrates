
(define-library
  (euphrates parselynn-latin)
  (export make-parselynn/latin)
  (import
    (only (euphrates parselynn) make-lexical-token))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates source-location)
          make-source-location))
  (import
    (only (scheme base)
          +
          <=
          _
          begin
          case
          close-port
          cond
          define
          else
          eof-object?
          equal?
          if
          lambda
          let
          list
          not
          open-input-string
          or
          port?
          quote
          read-char
          set!
          string?
          when))
  (cond-expand
    (guile (import (only (srfi srfi-67) <?)))
    (else (import (only (srfi 67) <?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-latin.scm")))
    (else (include "parselynn-latin.scm"))))
