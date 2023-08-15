
(catch-specific
 'type1
 (lambda _
   (generic-error (list (cons generic-error:type-key 'type1))))
 (lambda _ 'good))

(catch-specific
 'type1
 (lambda _
   (catch-specific
    'type2
    (lambda _
      (generic-error
       (list (cons generic-error:type-key 'type1))))
    (lambda _
      (generic-error
       (list (cons generic-error:type-key 'type-bad))))))
 (lambda _
   'good))
