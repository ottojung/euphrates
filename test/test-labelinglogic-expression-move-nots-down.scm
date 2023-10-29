
(define (test1 expr result)
  (assert=
   result
   (labelinglogic:expression:move-nots-down
    expr))

  (assert=
   result
   (labelinglogic:expression:move-nots-down
    result)))



(let ()
  (define expr
    `(and a (and b (and (tuple c (tuple d e))
                        (and (or f g)
                             (and h i))))))

  (define result expr)

  (test1 expr result))





(let ()
  (define expr
    `(not
      (and a (and b (and (tuple c (tuple d e))
                         (and (or f g)
                              (and h i)))))))

  (define result
    `(or (not a)
         (or (not b)
             (or (tuple (not c)
                        (tuple (not d)
                               (not e)))
                 (or (and (not f)
                          (not g))
                     (or (not h)
                         (not i)))))))

  (test1 expr result))







(let ()
  (define expr
    `(and a (and b (not (and (tuple c (tuple d e))
                             (and (or f g)
                                  (and h i)))))))

  (define result
    `(and a (and b (or (tuple (not c)
                              (tuple (not d)
                                     (not e)))
                       (or (and (not f)
                                (not g))
                           (or (not h)
                               (not i)))))))

  (test1 expr result))
