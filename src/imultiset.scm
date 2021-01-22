
%run guile

%use (multiset multiset-value) "./multiset.scm"
%use (hashmap) "./hashmap.scm"
%use (hashmap-ref hashmap-set! hashmap-count hashmap-foreach hashmap->alist) "./ihashmap.scm"

%var make-multiset
%var list->multiset
%var vector->multiset
%var multiset->list
%var multiset-equal?
%var multiset-ref
%var multiset-add!

(define (list->multiset lst)
  (multiset
   (let ((H (hashmap)))
     (for-each
      (lambda (key)
        (hashmap-set! H key (+ 1 (hashmap-ref H key 0))))
      lst)
     H)))

(define (vector->multiset v)
  (multiset
   (let ((H (hashmap)))
     (let loop ((i (- (vector-length v) 1)))
       (when (>= i 0)
         (let ((key (vector-ref v i)))
           (hashmap-set! H key (+ 1 (hashmap-ref H key 0))))))
     H)))

(define (make-multiset collection)
  (cond
   ((list? collection)
    (list->multiset collection))
   ((vector? collection)
    (vector->multiset collection))
   (else
    (throw 'expected-list? collection))))

(define (multiset->list S)
  (map car (hashmap->alist (multiset-value S))))

(define (each-is-equal? A B)
  ;; TODO: we may use continuation to escape early, but that might be unsafe
  (let ((ret #t))
    (hashmap-foreach
     (lambda (key value)
       (when ret
         (unless (eqv? value (hash-ref B key 0))
           (set! ret #f))))
     A)
    ret))

(define (multiset-equal? a b)
  (let ((A (multiset-value a))
        (B (multiset-value b)))
    (and (equal? (hashmap-count A)
                 (hashmap-count B))
         (each-is-equal? A B))))

(define (multiset-ref H key)
  (hash-ref (multiset-value H) key #f))
(define (multiset-add! H key)
  (hashmap-set! (multiset-value H)
                key
                (+ 1 (hashmap-ref (multiset-value H) key 0))))
