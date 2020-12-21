
%run guile

%var remove-common-prefix

(define [remove-common-prefix a b]
  (define (loop as bs)
    (cond
     ((null? as) as)
     ((null? bs) as)
     ((eq? (car as) (car bs))
      (loop (cdr as) (cdr bs)))
     (else as)))
  (cond
   ((string? a)
    (list->string
     (loop (string->list a) (string->list b))))
   ((list? a)
    (loop a b))
   (else
    (throw 'expecting-string-or-list a b))))


