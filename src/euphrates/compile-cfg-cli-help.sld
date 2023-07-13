
(define-library
  (euphrates compile-cfg-cli-help)
  (export CFG-AST->CFG-CLI-help)
  (import
    (only (euphrates alphanum-alphabet)
          alphanum/alphabet/index))
  (import (only (euphrates cfg-inline) CFG-inline))
  (import
    (only (euphrates cfg-remove-dead-code)
          CFG-remove-dead-code))
  (import
    (only (euphrates cfg-strip-modifiers)
          CFG-strip-modifiers))
  (import (only (euphrates compose) compose))
  (import
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort))
  (import
    (only (euphrates get-current-program-path)
          get-current-program-path))
  (import
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate))
  (import (only (euphrates list-fold) list-fold))
  (import
    (only (euphrates list-intersperse)
          list-intersperse))
  (import
    (only (euphrates list-map-flatten)
          list-map/flatten))
  (import (only (euphrates negate) negate))
  (import
    (only (euphrates parse-cfg-cli) CFG-CLI->CFG-AST))
  (import
    (only (euphrates path-get-basename)
          path-get-basename))
  (import
    (only (euphrates print-in-window)
          print-in-window))
  (import (only (euphrates range) range))
  (import (only (euphrates replicate) replicate))
  (import
    (only (euphrates string-pad) string-pad-R))
  (import
    (only (euphrates string-to-words) string->words))
  (import
    (only (euphrates system-environment)
          system-environment-get))
  (import (only (euphrates tilda-a) ~a))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base)
          +
          -
          _
          and
          append
          apply
          assoc
          begin
          car
          case
          cdr
          cond
          cons
          define
          else
          equal?
          for-each
          if
          lambda
          length
          let
          let*
          list
          list->string
          list?
          map
          max
          newline
          null?
          or
          quote
          string->list
          string->number
          string-append
          string-length
          string<?
          string?
          unless
          when))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-suffix?)))
    (else (import (only (srfi 13) string-suffix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/compile-cfg-cli-help.scm")))
    (else (include "compile-cfg-cli-help.scm"))))
