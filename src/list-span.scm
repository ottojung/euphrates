
%run guile

%var list-span

%use (raisu) "./raisu.scm"

;; equivalent to (take n lst, drop n lst)
;; list must be of length at least n
(define (list-span n lst)
  (let loop ((n n) (lst lst) (buf '()))
    (if (zero? n)
        (values (reverse buf) lst)
        (if (null? lst)
            (raisu 'list-span-too-short "List must be longer than" n)
            (loop (- n 1) (cdr lst) (cons (car lst) buf))))))
