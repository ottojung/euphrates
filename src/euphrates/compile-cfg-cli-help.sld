
(define-library
  (euphrates compile-cfg-cli-help)
  (export CFG-AST->CFG-CLI-help)
  (import
    (only (euphrates alphanum-alphabet)
          alphanum/alphabet/index)
    (only (euphrates cfg-inline) CFG-inline)
    (only (euphrates cfg-remove-dead-code)
          CFG-remove-dead-code)
    (only (euphrates cfg-strip-modifiers)
          CFG-strip-modifiers)
    (only (euphrates compose) compose)
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort)
    (only (euphrates get-current-program-path)
          get-current-program-path)
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-ref
          hashmap-set!
          make-hashmap)
    (only (euphrates list-deduplicate)
          list-deduplicate)
    (only (euphrates list-fold) list-fold)
    (only (euphrates list-intersperse)
          list-intersperse)
    (only (euphrates list-map-flatten)
          list-map/flatten)
    (only (euphrates negate) negate)
    (only (euphrates parse-cfg-cli) CFG-CLI->CFG-AST)
    (only (euphrates path-get-basename)
          path-get-basename)
    (only (euphrates print-in-window)
          print-in-window)
    (only (euphrates range) range)
    (only (euphrates replicate) replicate)
    (only (euphrates string-pad) string-pad-R)
    (only (euphrates string-to-words) string->words)
    (only (euphrates system-environment)
          system-environment-get)
    (only (euphrates tilda-a) ~a)
    (only (euphrates tilda-s) ~s)
    (only (euphrates with-output-to-string)
          with-output-to-string)
    (only (euphrates words-to-string) words->string)
    (only (srfi srfi-13) string-suffix?)
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
          when)
    (only (scheme write) display)
    (only (srfi srfi-1) filter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/compile-cfg-cli-help.scm")))
    (else (include "compile-cfg-cli-help.scm"))))
