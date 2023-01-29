
(cond-expand
 (guile
  (define-module (euphrates comp)
    :export (comp appcomp)
    :use-module ((euphrates partial-apply1) :select (partial-apply1)))))



;; `comp` operator from clojure
(define-syntax %comp-helper
  (syntax-rules ()
    ((_ buf ())
     (compose . buf))
    ((_ buf ((x . xs) . y))
     (%comp-helper ((partial-apply1 x . xs) . buf) y))
    ((_ buf (x . y))
     (%comp-helper (x . buf) y))))
(define-syntax-rule (comp . xs)
  (%comp-helper () xs))

;; thread (->>) operator from clojure
(define-syntax-rule (appcomp x . xs)
  ((comp . xs) x))
