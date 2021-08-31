
%run guile

%use (hashmap) "./hashmap.scm"

%var hashmap->alist
%var hashmap-copy
%var hashmap-foreach
%var alist->hashmap
%var multi-alist->hashmap
%var hashmap-ref
%var hashmap-set!
%var hashmap-clear!
%var hashmap-count

%for (COMPILER "guile")

(use-modules (ice-9 hash-table))

(define hashmap-ref hash-ref)
(define hashmap-set! hash-set!)
(define hashmap-clear! hash-clear!)

(define alist->hashmap alist->hash-table)

;; multi-alist example:
;;    '((a . 3) (b . 2) (a . 4))
;; which is equivalent to this alist:
;;    '((a . (4 3)) (b . (2)))
(define (multi-alist->hashmap multi-alist)
  (let ((ret (hashmap)))
    (for-each
     (lambda (p)
       (define key (car p))
       (define value (cdr p))
       (hash-set!
        ret key
        (cons value (hashmap-ref ret key '()))))
     multi-alist)
    ret))

(define (hashmap->alist h)
  (hash-map->list cons h))

(define (hashmap-copy h)
  (let [[ret (hashmap)]]
    (hash-for-each
     (lambda (key value)
       (hash-set! ret key value))
     h)
    ret))

(define hashmap-foreach hash-for-each)

(define (hashmap-count H) (hash-count (const #t) H))

%end
