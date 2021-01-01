
%run guile

%use (hashmap) "./hashmap.scm"

%var hashmap->alist
%var hashmap-copy
%var hashmap-foreach
%var alist->hashmap
%var hashmap-ref
%var hashmap-set!
%var hashmap-count

%for (COMPILER "guile")

(use-modules (ice-9 hash-table))

(define hashmap-ref hash-ref)
(define hashmap-set! hash-set!)

(define alist->hashmap alist->hash-table)

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
