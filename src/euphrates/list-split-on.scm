
(cond-expand
 (guile
  (define-module (euphrates list-split-on)
    :export (list-split-on))))


(define (list-split-on predicate lst)
  (let loop ((lst lst) (buf '()) (ret '()))
    (cond
     ((null? lst)
      (if (null? buf)
          (reverse ret)
          (reverse (cons (reverse buf) ret))))
     ((predicate (car lst))
      (loop (cdr lst) '()
            (if (null? buf) ret
                (cons (reverse buf) ret))))
     (else
      (loop (cdr lst) (cons (car lst) buf) ret)))))
