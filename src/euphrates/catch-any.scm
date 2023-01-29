
%run guile

%var catch-any

%for (COMPILER "guile")

(define [catch-any body handler]
  (catch #t body
    (lambda err (handler err))))

%end
%for (COMPILER "racket")
;; TODO
%end
