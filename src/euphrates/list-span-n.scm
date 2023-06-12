


;; equivalent to (list-take-n n lst, list-drop-n n lst)
;; list may be shorter than n
(define (list-span-n n lst)
  (let loop ((n n) (lst lst) (buf '()))
    (if (or (zero? n) (null? lst))
        (values (reverse buf) lst)
        (loop (- n 1) (cdr lst) (cons (car lst) buf)))))
