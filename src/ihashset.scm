
%run guile

%use (hashset hashset-value) "./hashset.scm"
%use (hashmap) "./hashmap.scm"
%use (hashmap-set! hashmap-copy hashmap-count hashmap-foreach hashmap-map hashmap->alist) "./ihashmap.scm"
%use (raisu) "./raisu.scm"

%var make-hashset
%var list->hashset
%var vector->hashset
%var hashset->list
%var hashset-equal?
%var hashset-ref
%var hashset-add!
%var hashset-difference
%var hashset-intersection
%var hashset-union
%var hashset-foreach
%var hashset-map

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

(define make-hashset
  (case-lambda
   (() (make-hashset '()))
   ((collection)
    (cond
     ((list? collection)
      (list->hashset collection))
     ((vector? collection)
      (vector->hashset collection))
     (else
      (raisu 'expected-list? collection))))))

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

(define (hashset-difference a b)
  (define H (hashmap))

  (let ((A (hashset-value a))
        (B (hashset-value b)))
    (hashmap-foreach
     (lambda (key value)
       (unless (hash-ref B key #f)
         (hashmap-set! H key #t)))
     A))

  (hashset H))

(define (hashset-intersection a b)
  (define H (hashmap))

  (let ((A (hashset-value a))
        (B (hashset-value b)))
    (hashmap-foreach
     (lambda (key value)
       (when (hash-ref B key #f)
         (hashmap-set! H key #t)))
     A))

  (hashset H))

(define (hashset-union a b)
  (define H (hashmap))

  (let ((A (hashset-value a))
        (B (hashset-value b)))
    (hashmap-foreach
     (lambda (key value)
       (hashmap-set! H key #t))
     A)
    (hashmap-foreach
     (lambda (key value)
       (hashmap-set! H key #t))
     B))

  (hashset H))


(define (hashset-foreach fn H)
  (define M (hashset-value H))

  (hashmap-foreach
   (lambda (key value)
     (fn key))
   M))

(define (hashset-map fn H)
  (define M (hashset-value H))
  (hashset (hashmap-map (lambda (key value) (fn key)) M)))
