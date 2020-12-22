
%run guile

%var make-hashmap
%var hash-table->alist
%var hash-copy
%var hash-table-foreach
%var alist->hash-table
%var hashmap-ref
%var hashmap-set!

%for (COMPILER "guile")

(use-modules (ice-9 hash-table))

(define hashmap-ref hash-ref)
(define hashmap-set! hash-set!)

(define make-hashmap make-hash-table)

(define alist->hash-table (@ (ice-9 hash-table) alist->hash-table))

(define [hash-table->alist h]
  (hash-map->list cons h))

(define [hash-copy h]
  (let [[ret (make-hash-table)]]
    (hash-for-each
     (lambda (key value)
       (hash-set! ret key value))
     h)
    ret))

(define [hash-table-foreach h procedure]
  (hash-for-each procedure h))

%end
