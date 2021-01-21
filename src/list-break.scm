
%run guile

%var list-break

;; equivalent to (takeWhile (negate predicate) lst, dropWhile (negate predicate) lst)
(define (list-break predicate lst)
  (let loop ((lst lst) (buf '()))
    (if (or (null? lst)
            (predicate (car lst)))
        (values (reverse buf) lst)
        (loop (cdr lst) (cons (car lst) buf)))))
