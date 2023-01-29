
%run guile

%var dynamic-load

(define (dynamic-load filepath)
  (load filepath))
