
%run guile

%use (hashset hashset-value) "./hashset.scm"
%use (hashmap) "./hashmap.scm"
%use (hashmap-set! hashmap-count hashmap-foreach hashmap->alist) "./ihashmap.scm"
%use (raisu) "./raisu.scm"

%var make-hashset
%var list->hashset
%var vector->hashset
%var hashset->list
%var hashset-equal?
%var hashset-ref
%var hashset-add!

(define (list->hashset lst)
  (hashset
   (let ((H (hashmap)))
     (for-each
      (lambda (key)
        (hashmap-set! H key #t))
      lst)
     H)))

(define (vector->hashset v)
  (hashset
   (let ((H (hashmap)))
     (let loop ((i (- (vector-length v) 1)))
       (when (>= i 0)
         (hashmap-set! H (vector-ref v i) #t)))
     H)))

(define (make-hashset collection)
  (cond
   ((list? collection)
    (list->hashset collection))
   ((vector? collection)
    (vector->hashset collection))
   (else
    (raisu 'expected-list? collection))))

(define (hashset->list S)
  (map car (hashmap->alist (hashset-value S))))

(define (hashset-equal? a b)
  (define (each-is-equal? A B)
    ;; TODO: we may use continuation to escape early, but that might be unsafe
    (let ((ret #t))
      (hashmap-foreach
       (lambda (key value)
         (when ret
           (unless (hash-ref B key #f)
             (set! ret #f))))
       A)
      ret))

  (let ((A (hashset-value a))
        (B (hashset-value b)))
    (and (equal? (hashmap-count A)
                 (hashmap-count B))
         (each-is-equal? A B))))

(define (hashset-ref H key)
  (hash-ref (hashset-value H) key #f))
(define (hashset-add! H key)
  (hash-set! (hashset-value H) key #t))
