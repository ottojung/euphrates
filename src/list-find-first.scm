
%run guile

%var list-find-first

%use (raisu) "./raisu.scm"

(define list-find-first
  (case-lambda
   ((f lst)
    (let loop ((lst lst))
      (if (null? lst) (raisu 'no-first-element-to-satisfy-predicate f)
          (let ((x (car lst)))
            (if (f x) x
                (loop (cdr lst)))))))
   ((f default lst)
    (let loop ((lst lst))
      (if (null? lst) default
          (let ((x (car lst)))
            (if (f x) x
                (loop (cdr lst)))))))))
