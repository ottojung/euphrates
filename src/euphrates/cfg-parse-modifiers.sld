
(define-library
  (euphrates cfg-parse-modifiers)
  (export CFG-parse-modifiers)
  (import
    (only (euphrates compile-cfg-cli)
          CFG-lang-modifier-char?)
    (only (euphrates list-span-while)
          list-span-while)
    (only (euphrates negate) negate)
    (only (euphrates tilda-a) ~a)
    (only (scheme base)
          begin
          define
          define-values
          list->string
          string->list
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/cfg-parse-modifiers.scm")))
    (else (include "cfg-parse-modifiers.scm"))))
