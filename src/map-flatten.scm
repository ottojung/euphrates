
%run guile

%var map/flatten

(define (map/flatten f L)
  (apply append (map f L)))
