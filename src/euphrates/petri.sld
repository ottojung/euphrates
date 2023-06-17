
(define-library
  (euphrates petri)
  (export petri-push petri-run)
  (import
    (only (euphrates cartesian-product-g)
          cartesian-product/g))
  (import (only (euphrates catch-any) catch-any))
  (import (only (euphrates curry-if) curry-if))
  (import
    (only (euphrates dynamic-thread-async)
          dynamic-thread-async))
  (import
    (only (euphrates dynamic-thread-critical-make)
          dynamic-thread-critical-make))
  (import
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-clear!
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-clear!
          hashset-has?
          make-hashset))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate))
  (import
    (only (euphrates list-map-flatten)
          list-map/flatten))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import
    (only (euphrates petri-error-handling)
          patri-handle-make-callback))
  (import
    (only (euphrates petri-net-obj)
          petri-net-obj-critical
          petri-net-obj-finished?
          petri-net-obj-queue
          petri-net-obj-transitions
          petri-net-obj?
          set-petri-net-obj-finished?!))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates range) range))
  (import
    (only (euphrates stack)
          stack-make
          stack-pop!
          stack-push!
          stack-unload!))
  (import
    (only (euphrates with-critical) with-critical))
  (import
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
          when))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/petri.scm")))
    (else (include "petri.scm"))))
