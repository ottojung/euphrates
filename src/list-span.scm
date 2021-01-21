
%run guile

%var list-span

;; equivalent to (takeWhile predicate lst, dropWhile predicate lst)
(define (list-span predicate lst)
  (let loop ((lst lst) (buf '()))
    (if (or (null? lst)
            (not (predicate (car lst))))
        (values (reverse buf) lst)
        (loop (cdr lst) (cons (car lst) buf)))))
