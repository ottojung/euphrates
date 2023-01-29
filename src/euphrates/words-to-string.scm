
%run guile

%var words->string

(define (words->string lns)
  (string-join (filter (negate string-null?) lns) " "))
