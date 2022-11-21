
%run guile

%var multiset-constructor
%var multiset-predicate
%var multiset-value

%use (define-type9) "./define-type9.scm"

(define-type9 multiset
  (multiset-constructor value) multiset-predicate
  (value multiset-value))
