
%run guile

%var list-deduplicate/reverse
%var list-deduplicate

%use (hashmap) "./hashmap.scm"
%use (hashmap-ref hashmap-set! hashmap-clear!) "./ihashmap.scm"

;; faster!
(define list-deduplicate/reverse
  (case-lambda
   ((lst) (list-deduplicate lst equal?))
   ((lst pred)
    (let ((H (hashmap)))
      (let lp ((buf lst) (mem '()))
        (cond ((null? buf) mem)
              ((hashmap-ref H (car buf) #f)
               (lp (cdr buf) mem))
              (else
               (hashmap-set! H (car buf) #t)
               (lp (cdr buf) (cons (car buf) mem)))))))))

(define list-deduplicate
  (case-lambda
   ((lst) (list-deduplicate lst equal?))
   ((lst pred)
    (let ((H (hashmap)))
      (let lp ((buf lst) (mem '()))
        (cond ((null? buf) (reverse mem))
              ((hashmap-ref H (car buf) #f)
               (lp (cdr buf) mem))
              (else
               (hashmap-set! H (car buf) #t)
               (lp (cdr buf) (cons (car buf) mem)))))))))
