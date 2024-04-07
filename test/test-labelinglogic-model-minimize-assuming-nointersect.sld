
(define-library
  (test-labelinglogic-model-minimize-assuming-nointersect)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import (only (euphrates hashset) list->hashset))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic:binding:name))
  (import
    (only (euphrates labelinglogic-model-alpha-rename)
          labelinglogic:model:alpha-rename))
  (import
    (only (euphrates labelinglogic-model-append)
          labelinglogic:model:append))
  (import
    (only (euphrates
            labelinglogic-model-minimize-assuming-nointersect)
          labelinglogic:model:minimize/assuming-nointersect))
  (import
    (only (scheme base)
          =
          _
          and
          begin
          define
          define-syntax
          equal?
          let
          map
          not
          or
          quasiquote
          quote
          syntax-rules
          unless))
  (import
    (only (scheme char)
          char-numeric?
          char-whitespace?))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-model-minimize-assuming-nointersect.scm")))
    (else (include
            "test-labelinglogic-model-minimize-assuming-nointersect.scm"))))
