
(define-library
  (euphrates alist-initialize-loop)
  (export alist-initialize-loop)
  (import
    (only (euphrates alist-initialize-bang)
          alist-initialize!
          alist-initialize!:get-setters
          alist-initialize!:makelet/static))
  (import (only (euphrates assq-or) assq-or))
  (import (only (euphrates fn-pair) fn-pair))
  (import
    (only (euphrates hashset)
          hashset-has?
          list->hashset))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate))
  (import
    (only (euphrates syntax-append) syntax-append))
  (import (only (euphrates syntax-map) syntax-map))
  (import
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
          unless))
  (cond-expand
    (guile (import (only (srfi srfi-17) setter)))
    (else (import (only (srfi 17) setter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/alist-initialize-loop.scm")))
    (else (include "alist-initialize-loop.scm"))))
