
(catch-many
 (list 'type1)
 (lambda _
   (generic-error (list (cons generic-error:type-key 'type1))))
 (lambda _ 'good))

(catch-many
 (list 'type1)
 (lambda _
   (catch-many
    (list 'type2)
    (lambda _
      (generic-error
       (list (cons generic-error:type-key 'type1))))
    (lambda _
      (generic-error
       (list (cons generic-error:type-key 'type-bad))))))
 (lambda _
   'good))
