
(cond-expand
 (guile
  (define-module (euphrates hashmap)
    :export (make-hashmap hashmap? hashmap->alist hashmap-copy hashmap-foreach hashmap-map alist->hashmap multi-alist->hashmap hashmap-has? hashmap-ref hashmap-set! hashmap-clear! hashmap-count hashmap-delete! hashmap-merge! hashmap-merge)
    :use-module ((euphrates fn) :select (fn))
    :use-module ((euphrates hashmap-obj) :select (hashmap-constructor hashmap-predicate))
    :use-module ((euphrates make-unique) :select (make-unique))
    :use-module ((euphrates raisu) :select (raisu)))))



(cond-expand
 (guile

  (use-modules (ice-9 hash-table))

  (define hashmap? hashmap-predicate)
  (define make-hashmap hashmap-constructor)
  (define hashmap-true-ref hash-ref)
  (define hashmap-set! hash-set!)
  (define hashmap-clear! hash-clear!)

  (define alist->hashmap alist->hash-table)

  (define (hashmap->alist h)
    (hash-map->list cons h))

  (define (hashmap-copy h)
    (let [[ret (make-hashmap)]]
      (hash-for-each
       (lambda (key value)
     (hash-set! ret key value))
       h)
      ret))

  (define hashmap-foreach hash-for-each)

  (define (hashmap-count H) (hash-count (const #t) H))

  (define (hashmap-delete! H key)
    (hash-remove! H key))

  ))

(define hashmap-ref-default-value
  (make-unique))

(define (hashmap-has? H key)
  (define get
    (hashmap-true-ref H key hashmap-ref-default-value))
  (eq? get hashmap-ref-default-value))

(define-syntax hashmap-ref
  (syntax-rules ()
    ((_ H key0)
     (let ((key key0))
       (hashmap-ref
        H key
        (raisu 'hashmap-key-not-found key))))
    ((_ H key default)
     (let ((get (hashmap-true-ref H key hashmap-ref-default-value)))
       (if (eq? get hashmap-ref-default-value)
           default
           get)))))

;; multi-alist example:
;;    '((a . 3) (b . 2) (a . 4))
;; which is equivalent to this alist:
;;    '((a . (4 3)) (b . (2)))
(define (multi-alist->hashmap multi-alist)
  (let ((ret (make-hashmap)))
    (for-each
     (lambda (p)
       (define key (car p))
       (define value (cdr p))
       (hashmap-set!
        ret key
        (cons value (hashmap-ref ret key '()))))
     multi-alist)
    ret))

(define (hashmap-map fn H)
  (define ret (make-hashmap))

  (hashmap-foreach
   (lambda (key value)
     (hashmap-set! ret key (fn key value)))
   H)

  ret)

;; Merges two hashmaps.
;; If `f' is provided then it will be applied to values with the same key.
(define hashmap-merge!
  (let ((unique (make-unique)))
    (case-lambda
     ((base other)
      (hashmap-foreach
       (lambda (key value) (hashmap-set! base key value))
       other))
     ((base other f)
      (hashmap-foreach
       (lambda (key value)
         (define base-value (hashmap-ref base key unique))
         (if (eq? unique base-value)
             (hashmap-set! base key value)
             (hashmap-set! base key (f key base-value value))))
       other)))))

(define hashmap-merge
  (case-lambda
   ((a b)
    (let ((new (hashmap-copy a)))
      (hashmap-merge! new b)
      new))
   ((a b f)
    (let ((new (hashmap-copy a)))
      (hashmap-merge! new b f)
      new))))
