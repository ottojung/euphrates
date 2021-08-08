
%run guile

%var open-cond
%var open-cond?
%var open-cond-value
%var set-open-cond-value!

%use (define-newtype) "./define-newtype.scm"

(define-newtype open-cond open-cond? open-cond-value set-open-cond-value!)

