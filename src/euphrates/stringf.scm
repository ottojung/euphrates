
%run guile

%use (printf) "./printf.scm"

%var stringf

(define (stringf fmt . args)
  (with-output-to-string
    (lambda []
      (apply printf (cons fmt args)))))
