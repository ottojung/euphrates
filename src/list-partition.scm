
%run guile

%var list-partition

%use (hashmap->alist hashmap-ref hashmap-set! make-hashmap) "./ihashmap.scm"

(define (list-partition distriminator L)
  (define H (make-hashmap))

  (for-each
   (lambda (elem)
     (define key (distriminator elem))
     (hashmap-set! H key (cons elem (hashmap-ref H key '()))))
   L)

  (hashmap->alist H))
