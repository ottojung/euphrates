
(define-library
  (test-parselynn-simple)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates assert) assert))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates list-collapse) list-collapse))
  (import
    (only (euphrates parselynn-simple-deserialize)
          parselynn:simple:deserialize))
  (import
    (only (euphrates parselynn-simple-diff)
          parselynn:simple:diff))
  (import
    (only (euphrates parselynn-simple-join1)
          parselynn:simple:join1))
  (import
    (only (euphrates
            parselynn-simple-run-with-error-handler)
          parselynn:simple:run/with-error-handler))
  (import
    (only (euphrates parselynn-simple-serialize)
          parselynn:simple:serialize))
  (import
    (only (euphrates parselynn-simple)
          parselynn:simple))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          +
          /
          =
          _
          and
          apply
          begin
          car
          cdr
          define
          define-syntax
          eof-object
          equal?
          even?
          if
          lambda
          let
          list
          list?
          map
          modulo
          negative?
          not
          null?
          odd?
          or
          positive?
          quasiquote
          quote
          set!
          string
          string->number
          string-append
          string?
          syntax-rules
          unless
          unquote))
  (import (only (scheme process-context) exit))
  (cond-expand
    (guile (import (only (srfi srfi-1) any delete filter)))
    (else (import (only (srfi 1) any delete filter))))
  (cond-expand
    (guile (import (only (srfi srfi-41) stream)))
    (else (import (only (srfi 41) stream))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-parselynn-simple.scm")))
    (else (include "test-parselynn-simple.scm"))))
