
(cond-expand
 (guile
  (define-module (euphrates list-deduplicate)
    :export (list-deduplicate/reverse list-deduplicate)
    :use-module ((euphrates hashset) :select (hashset-add! hashset-has? make-hashset)))))



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
