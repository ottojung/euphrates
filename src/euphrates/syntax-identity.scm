
%run guile

%var syntax-identity

(define-syntax syntax-identity
  (syntax-rules ()
    ((_ x) x)))
