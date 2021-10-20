
%run guile

%var monadic-id

%use (monadic) "./monadic.scm"
%use (monad-identity) "./monad-identity.scm"

(define-syntax monadic-id
  (syntax-rules ()
    ((_ . argv)
     (monadic monad-identity . argv))))
