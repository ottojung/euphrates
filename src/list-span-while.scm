
%run guile

%var list-span-while

;; equivalent to (takeWhile predicate lst, dropWhile predicate lst)
(define (list-span-while predicate lst)
  (let loop ((lst lst) (buf '()))
    (if (or (null? lst)
            (not (predicate (car lst))))
        (values (reverse buf) lst)
        (loop (cdr lst) (cons (car lst) buf)))))
