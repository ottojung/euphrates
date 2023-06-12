
(define-library
  (euphrates define-cli)
  (export
    make-cli/f/basic
    make-cli/f
    make-cli
    make-cli-with-handler
    lambda-cli
    with-cli
    define-cli:raisu/p
    define-cli:raisu/default-exit
    define-cli:show-help)
  (import
    (only (euphrates cfg-machine) make-cfg-machine)
    (only (euphrates compile-cfg-cli-help)
          CFG-AST->CFG-CLI-help)
    (only (euphrates compile-cfg-cli)
          CFG-CLI->CFG-lang)
    (only (euphrates compose) compose)
    (only (euphrates define-pair) define-pair)
    (only (euphrates get-command-line-arguments)
          get-command-line-arguments)
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap)
    (only (euphrates immutable-hashmap)
          alist->immutable-hashmap
          immutable-hashmap-foreach
          immutable-hashmap-ref/first)
    (only (euphrates list-init) list-init)
    (only (euphrates list-last) list-last)
    (only (euphrates syntax-flatten-star)
          syntax-flatten*)
    (only (euphrates tilda-a) ~a)
    (only (scheme base)
          /
          _
          append
          apply
          begin
          cadr
          car
          case
          cdr
          cond
          cons
          current-error-port
          define
          define-syntax
          define-values
          else
          equal?
          error
          for-each
          if
          lambda
          let
          let*
          list
          list-ref
          list?
          make-parameter
          map
          newline
          not
          null?
          number->string
          number?
          parameterize
          quote
          reverse
          string->number
          string->symbol
          symbol->string
          symbol?
          syntax-rules
          unless
          values
          when)
    (only (scheme process-context) exit)
    (only (scheme write) display)
    (only (srfi srfi-42) :))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/define-cli.scm")))
    (else (include "define-cli.scm"))))
