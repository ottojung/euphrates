
%run guile

%var group-by/sequential*
%var group-by/sequential

;; Splits `lst' into groups that
;;  are closed under (predicate x[n] x[n+1:])
;; NOTE: order is preserved
;; NOTE: second argument is a list!
(define (group-by/sequential* predicate lst)
  (if (null? lst) '()
      (let loop ((lst lst) (g (list (car lst))) (buf '()))
        (cond
         ((null? (cdr lst))
          (if (null? g)
              (reverse buf)
              (reverse (cons (reverse g) buf))))
         (else
          (let* ((x (car lst))
                 (xs (cdr lst))
                 (y (car xs))
                 (p? (predicate x xs)))
            (loop (cdr lst)
                  (if p?
                      (cons y g)
                      (list y))
                  (if p? buf (cons (reverse g) buf)))))))))

;; Same as `group-by/sequential*'
;;  but predicate works on single elements
(define (group-by/sequential predicate lst)
  (group-by/sequential*
   (lambda (x xs)
     (or (null? xs)
         (predicate x (car xs))))
   lst))
