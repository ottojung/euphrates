

%run guile

%var hashset
%var hashset?
%var hashset-value

%use (define-newtype) "./define-newtype.scm"

(define-newtype hashset hashset? hashset-value)
