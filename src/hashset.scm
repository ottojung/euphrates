

%run guile

%var hashset
%var hashset?
%var hashset-value

%for (COMPILER "guile")
(use-modules (srfi srfi-9))
%end

(define-record-type <hashset>
  (hashset value) hashset?
  (value hashset-value))
