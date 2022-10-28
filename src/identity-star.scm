
%run guile

%var identity*

(define (identity* . args)
  (apply values args))
