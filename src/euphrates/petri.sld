
(define-library
  (euphrates petri)
  (export petri-push petri-run)
  (import
    (only (euphrates cartesian-product-g)
          cartesian-product/g)
    (only (euphrates catch-any) catch-any)
    (only (euphrates curry-if) curry-if)
    (only (euphrates dynamic-thread-async)
          dynamic-thread-async)
    (only (euphrates dynamic-thread-critical-make)
          dynamic-thread-critical-make)
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-clear!
          hashmap-ref
          hashmap-set!
          make-hashmap)
    (only (euphrates hashset)
          hashset-add!
          hashset-clear!
          hashset-has?
          make-hashset)
    (only (euphrates identity) identity)
    (only (euphrates list-deduplicate)
          list-deduplicate)
    (only (euphrates list-map-flatten)
          list-map/flatten)
    (only (euphrates list-or-map) list-or-map)
    (only (euphrates petri-error-handling)
          patri-handle-make-callback)
    (only (euphrates petri-net-obj)
          petri-net-obj-critical
          petri-net-obj-finished?
          petri-net-obj-queue
          petri-net-obj-transitions
          petri-net-obj?
          set-petri-net-obj-finished?!)
    (only (euphrates raisu) raisu)
    (only (euphrates range) range)
    (only (euphrates stack)
          stack-make
          stack-pop!
          stack-push!
          stack-unload!)
    (only (euphrates with-critical) with-critical)
    (only (scheme base)
          +
          =
          _
          and
          apply
          assoc
          begin
          cadr
          car
          cddr
          cdr
          cons
          current-error-port
          define
          eq?
          for-each
          if
          lambda
          length
          let
          let*
          list
          make-parameter
          map
          newline
          null?
          parameterize
          quasiquote
          quote
          set!
          unless
          unquote
          values
          when)
    (only (scheme case-lambda) case-lambda)
    (only (scheme write) display)
    (only (srfi srfi-1) filter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/petri.scm")))
    (else (include "petri.scm"))))
