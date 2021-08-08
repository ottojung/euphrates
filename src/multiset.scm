
%run guile

%var multiset
%var multiset?
%var multiset-value

%use (define-newtype) "./define-newtype.scm"

(define-newtype multiset multiset? multiset-value)

