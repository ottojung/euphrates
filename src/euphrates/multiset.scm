



(define multiset? multiset-predicate)

(define (list->multiset lst)
  (multiset-constructor
   (let ((H (make-hashmap)))
     (for-each
      (lambda (key)
        (hashmap-set! H key (+ 1 (hashmap-ref H key 0))))
      lst)
     H)))

(define (vector->multiset v)
  (multiset-constructor
   (let ((H (make-hashmap)))
     (let loop ((i (- (vector-length v) 1)))
       (when (>= i 0)
         (let ((key (vector-ref v i)))
           (hashmap-set! H key (+ 1 (hashmap-ref H key 0))))))
     H)))

(define (make-multiset)
  (list->multiset '()))

(define (multiset->list S)
  (define H (multiset-value S))
  (define ret '())

  (hashmap-foreach
   (lambda (key value)
     (for-each
      (lambda _ (set! ret (cons key ret)))
      (iota value)))
   H)

  ret)

(define (multiset-equal? a b)
  (define (each-is-equal? A B)
    ;; TODO: we may use continuation to escape early, but that might be unsafe
    (let ((ret #t))
      (hashmap-foreach
       (lambda (key value)
         (when ret
           (unless (eqv? value (hashmap-ref B key 0))
             (set! ret #f))))
       A)
      ret))

  (let ((A (multiset-value a))
        (B (multiset-value b)))
    (and (equal? (hashmap-count A)
                 (hashmap-count B))
         (each-is-equal? A B))))

(define-syntax multiset-ref
  (syntax-rules ()
    ((_ H key0)
     (let ((key key0))
       (multiset-ref
        H key (raisu 'hashset-key-not-found key))))
    ((_ H key default)
     (let ((get (hashmap-ref (hashset-value H) key #f)))
       (or get default)))))

(define (multiset-has? S key)
  (hashmap-ref (hashset-value S) key #f))

(define (multiset-add! H key)
  (hashmap-set! (multiset-value H)
                key
                (+ 1 (hashmap-ref (multiset-value H) key 0))))

(define (multiset-foreach/key-value fun S)
  (define H (multiset-value S))
  (hashmap-foreach
   (lambda (key value)
     (fun key value))
   H))

(define (multiset-foreach fun S)
  (define H (multiset-value S))
  (hashmap-foreach
   (lambda (key value)
     (for-each
      (lambda _ (fun key))
      (iota value)))
   H))

(define (multiset-filter S predicate)
  (define H (multiset-value S))
  (define R (list->multiset '()))
  (define RH (multiset-value R))
  (hashmap-foreach
   (lambda (key value)
     (when (predicate key value)
       (hashmap-set! RH key value)))
   H)
  R)

(define (multiset-keys S)
  (define H (multiset-value S))
  (map car (hashmap->alist H)))
