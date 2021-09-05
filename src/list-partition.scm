
%run guile

%var list-partition

%use (hashmap) "./hashmap.scm"
%use (hashmap-ref hashmap-set! hashmap->alist) "./ihashmap.scm"

(define (list-partition distriminator L)
  (define H (hashmap))

  (for-each
   (lambda (elem)
     (define key (distriminator elem))
     (hashmap-set! H key (cons elem (hashmap-ref H key '()))))
   L)

  (hashmap->alist H))
