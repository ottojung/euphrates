
(cond-expand
 (guile
  (define-module (euphrates package)
    :export (use-svars with-svars with-package make-package make-static-package)
    :use-module ((euphrates hashmap) :select (make-hashmap hashmap-ref hashmap-set!)))))



;; This is for ad hoc polymorphism
;; Faster than gfunc, but also more limited
;; Similar to SML parametric modules

(define-syntax with-svars-helper
  (syntax-rules []
    [[_ dict buf [] body]
     (lambda dict
       (let buf body))]
    [[_ dict buf [name . names] body]
     (with-svars-helper
      dict
      ((name
        (let [[z (assq (quote name) dict)]]
          (if z (cdr z) name))) . buf)
      names
      body)]))

(define-syntax-rule [with-svars names body]
  (with-svars-helper dd () names body))

(define-syntax use-svars-helper
  (syntax-rules []
    [[_ [] [] f] (f)]
    [[_ buf [] f] (f . buf)]
    [[_ buf [[name value] . names] f]
     (use-svars-helper
      ((cons (quote name) value) . buf)
      names
      f)]))

(define-syntax-rule [use-svars f . renames]
  (use-svars-helper [] renames f))

(define-syntax make-static-package-helper
  (syntax-rules []
    [[_ hh buf []]
     (let [[hh (make-hashmap)]]
       (begin . buf)
       hh)]
    [[_ hh buf [[name value] . definitions]]
     (make-static-package-helper
      hh
      [(hashmap-set! hh
                     (quote name)
                     value) . buf]
      definitions)]))

(define-syntax-rule [make-static-package definitions]
  (make-static-package-helper hh [] definitions))

(define-syntax-rule [make-package inputs definitions]
  (with-svars
   inputs
   (make-static-package definitions)))

(define-syntax with-package-helper
  (syntax-rules []
    [[_ inst [] body] body]
    [[_ inst [name . names] body]
     (let [[name (hashmap-ref inst (quote name))]]
       (with-package-helper
        inst
        names
        body))]))

(define-syntax with-package-renames-helper-pre
  (syntax-rules []
    [[_ [package . renames]]
     (use-svars package . renames)]
    [[_ package]
     (package)]))

(define-syntax-rule [with-package package-spec names body]
  (let [[inst (with-package-renames-helper-pre package-spec)]]
    (with-package-helper inst names body)))
