
%run guile

%var ~a

(define (~a x)
  (with-output-to-string
    (lambda _
      (display x))))


