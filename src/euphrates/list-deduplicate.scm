
%run guile

%var list-deduplicate/reverse
%var list-deduplicate

%use (hashset-add! hashset-has? make-hashset) "./hashset.scm"

;; faster!
(define list-deduplicate/reverse
  (case-lambda
   ((lst) (list-deduplicate/reverse lst identity))
   ((lst projection)
    (let ((H (make-hashset)))
      (let lp ((buf lst) (mem '()))
        (cond ((null? buf) mem)
              ((hashset-has? H (projection (car buf)))
               (lp (cdr buf) mem))
              (else
               (hashset-add! H (projection (car buf)))
               (lp (cdr buf) (cons (car buf) mem)))))))))

(define list-deduplicate
  (case-lambda
   ((lst) (list-deduplicate lst identity))
   ((lst projection)
    (let ((H (make-hashset)))
      (let lp ((buf lst) (mem '()))
        (cond ((null? buf) (reverse mem))
              ((hashset-has? H (projection (car buf)))
               (lp (cdr buf) mem))
              (else
               (hashset-add! H (projection (car buf)))
               (lp (cdr buf) (cons (car buf) mem)))))))))
