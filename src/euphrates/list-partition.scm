
(cond-expand
 (guile
  (define-module (euphrates list-partition)
    :export (list-partition)
    :use-module ((euphrates hashmap) :select (hashmap->alist hashmap-ref hashmap-set! make-hashmap)))))



(define (list-partition distriminator L)
  (define H (make-hashmap))

  (for-each
   (lambda (elem)
     (define key (distriminator elem))
     (hashmap-set! H key (cons elem (hashmap-ref H key '()))))
   L)

  (hashmap->alist H))
