
%run guile

%var ~s

(define (~s x)
  (with-output-to-string
    (lambda _
      (write x))))
