
%run guile

%use (cartesian-map) "./cartesian-map.scm"

%var cartesian-product

(define (cartesian-product a b)
  (cartesian-map cons a b))
