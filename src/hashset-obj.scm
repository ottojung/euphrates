
%run guile

%var hashset-constructor
%var hashset-predicate
%var hashset-value

%use (define-type9) "./define-type9.scm"

(define-type9 hashset
  (hashset-constructor value) hashset-predicate
  (value hashset-value))
