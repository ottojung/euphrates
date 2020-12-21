
%run guile

%var ~a

(define (~a x)
  (with-output-to-string
    (lambda _
      (write x))))
