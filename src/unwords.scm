
%run guile

%var unwords

(define (unwords lns)
  (string-join (filter (negate string-null?) lns) " "))
