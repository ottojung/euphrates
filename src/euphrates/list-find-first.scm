
%run guile

%var list-find-first

%use (raisu) "./raisu.scm"

(define-syntax list-find-first
  (syntax-rules ()
    ((_ f lst)
     (list-find-first
      f (raisu 'no-first-element-to-satisfy-predicate f)
      lst))
    ((_ f0 default lst0)
     (let ((f f0) (lst lst0))
       (let loop ((lst lst))
         (if (null? lst) default
             (let ((x (car lst)))
               (if (f x) x
                   (loop (cdr lst))))))))))
