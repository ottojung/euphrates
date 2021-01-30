
%run guile

%var list->tree

%for (COMPILER "guile")

(use-modules (srfi srfi-11))

%end

(define (list->tree lst divider)
  (define (recur tag rest)
    (define droped (list))
    (define taken
      (let lp ((lst rest))
        (if (null? lst)
            (list)
            (let* ((x (car lst))
                   (xs (cdr lst)))
              (let-values
                  (((action d) (divider x xs)))
                (case action
                  ((open)
                   (let-values
                       (((sub right) (recur x xs)))
                     (cons (append d sub)
                           (lp right))))
                  ((close)
                   (set! droped xs)
                   d)
                  ((turn)
                   (lp d))
                  ((replace)
                   (cons d (lp xs)))
                  (else
                   (cons x (lp xs)))))))))

    (values taken droped))

  (let-values
      (((pre post) (recur 'root lst)))
    pre))

