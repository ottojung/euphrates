
%run guile

%var open-cond-constructor
%var open-cond-predicate
%var open-cond-value
%var set-open-cond-value!

%use (define-type9) "./define-type9.scm"

(define-type9 open-cond
  (open-cond-constructor value) open-cond-predicate
  (value open-cond-value set-open-cond-value!))
