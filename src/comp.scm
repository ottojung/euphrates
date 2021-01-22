
%run guile

%use (partial-apply1) "./partial-apply1.scm"

%var comp
%var appcomp

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
