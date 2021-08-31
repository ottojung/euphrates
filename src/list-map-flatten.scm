
%run guile

%var list-map/flatten

(define (list-map/flatten f L)
  (apply append (map f L)))
