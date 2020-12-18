
%run guile

%var catch-any

(define [catch-any body handler]
  (catch #t body
    (lambda err (handler err))))
