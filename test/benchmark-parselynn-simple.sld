
(define-library
  (benchmark-parselynn-simple)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import (only (euphrates assoc-or) assoc-or))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates keylist-to-alist)
          keylist->alist))
  (import
    (only (euphrates parselynn-core-load-from-disk)
          parselynn:core:load-from-disk))
  (import
    (only (euphrates parselynn-core-serialize)
          parselynn:core:serialize))
  (import
    (only (euphrates
            parselynn-simple-run-with-error-handler)
          parselynn:simple:run/with-error-handler))
  (import
    (only (euphrates parselynn-simple-struct)
          make-parselynn:simple:struct
          parselynn:simple:struct:arguments
          parselynn:simple:struct:backend-parser
          parselynn:simple:struct:transformations))
  (import
    (only (euphrates parselynn-simple)
          parselynn:simple))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates with-benchmark-simple)
          with-benchmark/simple
          with-benchmark/timestamp))
  (import
    (only (scheme base)
          +
          -
          /
          <
          =
          >=
          _
          and
          begin
          car
          case
          cond
          define
          else
          eof-object
          equal?
          if
          lambda
          let
          make-string
          not
          odd?
          or
          pair?
          procedure?
          quasiquote
          quote
          remainder
          set!
          string
          string->symbol
          string-length
          string-map
          string-ref
          unquote
          when))
  (import
    (only (scheme file) call-with-output-file))
  (import (only (scheme write) write))
  (cond-expand
    (guile (import (only (srfi srfi-1) any count)))
    (else (import (only (srfi 1) any count))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "benchmark-parselynn-simple.scm")))
    (else (include "benchmark-parselynn-simple.scm"))))
