
%run guile

%var list-deduplicate

%use (hashmap) "./hashmap.scm"
%use (hashmap-ref hashmap-set! hashmap-clear!) "./ihashmap.scm"

;; returns list in reverse order
(define list-deduplicate
  (let ((H/p (make-parameter (hashmap)))) ;; thread-local
    (case-lambda
     ((lst) (list-deduplicate lst equal?))
     ((lst pred)
      (let ((H (H/p)))
        (hashmap-clear! H)
        (let lp ((buf lst) (mem (list)))
          (cond ((null? buf) mem)
                ((hashmap-ref H (car buf) #f)
                 (lp (cdr buf) mem))
                (else
                 (hashmap-set! H (car buf) #t)
                 (lp (cdr buf) (cons (car buf) mem))))))))))
