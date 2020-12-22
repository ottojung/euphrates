
%run guile

%use (cons*) "./cons-star.scm"

%var list-intersperse

(define (list-intersperse element lst)
  (let lp ((buf lst))
    (if (pair? buf)
        (let ((rest (cdr buf)))
          (if (null? rest)
              buf
              (cons* (car buf)
                     element
                     (lp rest))))
        null)))

