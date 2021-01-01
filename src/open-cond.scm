
%run guile

%var open-cond
%var open-cond?
%var open-cond-value
%var set-open-cond-value!

%for (COMPILER "guile")
(use-modules (srfi srfi-9))
%end

(define-record-type <open-cond>
  (open-cond value) open-cond?
  (value open-cond-value set-open-cond-value!))

