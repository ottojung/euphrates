
%run guile

%var range

(define range
  (case-lambda
    ((start count)
     (if (> count 0)
         (cons start (range (+ 1 start) (- count 1)))
         '()))
    ((count)
     (range 0 count))))
