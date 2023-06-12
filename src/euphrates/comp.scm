



;; `comp` operator from clojure
(define-syntax %comp-helper
  (syntax-rules ()
    ((_ buf ())
     (compose . buf))
    ((_ buf ((x . xs) . y))
     (%comp-helper ((partial-apply1 x . xs) . buf) y))
    ((_ buf (x . y))
     (%comp-helper (x . buf) y))))

(define-syntax comp
  (syntax-rules ()
    ((_ . xs)
     (%comp-helper () xs))))

;; thread (->>) operator from clojure
(define-syntax appcomp
  (syntax-rules ()
    ((_ x . xs)
     ((comp . xs) x))))
