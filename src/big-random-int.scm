
%run guile

%var big-random-int

%use (get-current-random-source) "./get-current-random-source.scm"
%use (random-source-make-integers) "./srfi-27-generic.scm"

(define big-random-int
  (lambda (max)
    ((random-source-make-integers
      (get-current-random-source)) max)))
