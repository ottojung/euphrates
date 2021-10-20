
%run guile

%var monad-identity

%use (monad-ret-id) "./monad.scm"

(define monad-identity
  (lambda monad-input (monad-ret-id monad-input)))
