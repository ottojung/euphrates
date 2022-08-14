
%run guile

%var list-deduplicate/reverse
%var list-deduplicate

%use (make-hashset hashset-ref hashset-add!) "./ihashset.scm"

;; faster!
(define list-deduplicate/reverse
  (case-lambda
   ((lst) (list-deduplicate/reverse lst identity))
   ((lst projection)
    (let ((H (make-hashset)))
      (let lp ((buf lst) (mem '()))
        (cond ((null? buf) mem)
              ((hashset-ref H (projection (car buf)))
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
              ((hashset-ref H (projection (car buf)))
               (lp (cdr buf) mem))
              (else
               (hashset-add! H (projection (car buf)))
               (lp (cdr buf) (cons (car buf) mem)))))))))
