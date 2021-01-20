
%run guile

%var multiset
%var multiset?
%var multiset-value

%for (COMPILER "guile")
(use-modules (srfi srfi-9))
%end

(define-record-type <multiset>
  (multiset value) multiset?
  (value multiset-value))
