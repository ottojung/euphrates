
%run guile

%var monadic-bare
%var monadic

%use (identity*) "./identity-star.scm"
%use (monad-current/p) "./monad-current-p.scm"
%use (monadic-do/generic) "./monadic-do.scm"
%use (with-monad) "./with-monad.scm"

;; This is something like "do syntax" from Haskell
(define-syntax monadic-bare-helper
  (syntax-rules ()

    ((_ f ((x . xs) y . tags) . ())
     (monadic-do/generic
      (f (x . xs) y (list . tags))
      identity*))

    ((_ f ((x . xs) y . tags) . bodies)
     (monadic-do/generic
      (f (x . xs) y (list . tags))
      (lambda (x . xs) (monadic-bare-helper f . bodies))))

    ((_ f (x y . tags) . ())
     (monadic-do/generic
      (f x y (list . tags))
      identity))

    ((_ f (x y . tags) . bodies)
     (monadic-do/generic
      (f x y (list . tags))
      (lambda (x) (monadic-bare-helper f . bodies))))))

(define-syntax monadic
  (syntax-rules ()
    ((_ fexpr . argv)
     (with-monad fexpr (monadic-bare-helper (monad-current/p) . argv)))))
