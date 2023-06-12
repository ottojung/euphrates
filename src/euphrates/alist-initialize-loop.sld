
(define-library
  (euphrates alist-initialize-loop)
  (export alist-initialize-loop)
  (import
    (only (euphrates alist-initialize-bang)
          alist-initialize!
          alist-initialize!:get-setters
          alist-initialize!:makelet/static)
    (only (euphrates assq-or) assq-or)
    (only (euphrates fn-pair) fn-pair)
    (only (euphrates hashset)
          hashset-has?
          list->hashset)
    (only (euphrates list-and-map) list-and-map)
    (only (euphrates list-deduplicate)
          list-deduplicate)
    (only (euphrates syntax-append) syntax-append)
    (only (euphrates syntax-map) syntax-map)
    (only (scheme base)
          _
          and
          begin
          car
          cons
          define
          define-syntax
          if
          lambda
          let
          let*
          map
          not
          or
          quote
          syntax-rules
          unless)
    (only (srfi srfi-17) setter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/alist-initialize-loop.scm")))
    (else (include "alist-initialize-loop.scm"))))
