
%run guile

%var monadic-bare
%var monadic

%use (identity*) "./identity-star.scm"
%use (monad-current-arg/p) "./monad-current-arg-p.scm"
%use (monad-current/p) "./monad-current-p.scm"
%use (monad-do/generic) "./monad-do.scm"
%use (monadarg-make-empty) "./monadarg.scm"
%use (monadfin monadfin-lval) "./monadfin.scm"
%use (monadic-global/p) "./monadic-global-p.scm"

;; This is something like "do syntax" from Haskell
(define-syntax monadic-bare-helper
  (syntax-rules ()

    ((_ f ((x . xs) y . tags) . ())
     (monad-do/generic
      (f (x . xs) y (list . tags))
      identity*))

    ((_ f ((x . xs) y . tags) . bodies)
     (monad-do/generic
      (f (x . xs) y (list . tags))
      (lambda (x . xs) (monadic-bare-helper f . bodies))))

    ((_ f (x y . tags) . ())
     (monad-do/generic
      (f x y (list . tags))
      identity))

    ((_ f (x y . tags) . bodies)
     (monad-do/generic
      (f x y (list . tags))
      (lambda (x) (monadic-bare-helper f . bodies))))))

(define-syntax monadic-bare
  (syntax-rules ()
    ((_ m . args)
     (apply
      values
      (call-with-values
          (lambda _
            (monadic-bare-helper m . args))
        (lambda results
          ((monadfin-lval
            (m (monadfin
                (lambda _ (map (lambda (f) (f)) results))))))))))))

;; NOTE: uses parameterization
(define-syntax monadic
  (syntax-rules ()
    ((_ fexpr . argv)
     (let* ((p (monadic-global/p))
            (f fexpr)
            (m (if p (p f (quote fexpr)) f)))
       (parameterize ((monad-current/p m)
                      (monad-current-arg/p (monadarg-make-empty)))
         (monadic-bare m . argv))))))
