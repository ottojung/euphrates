
(define-syntax test1
  (syntax-rules ()
    ((_ expr result)
     (let ()
       (assert=
        result
        (labelinglogic:expression:move-nots-down
         expr))

       (assert=
        result
        (labelinglogic:expression:move-nots-down
         result))))))




(let ()
  (define expr
    '(not (and a (or b c))))

  (define result
    '(or (not a) (and (not b) (not c))))

  (test1 expr result))






(let ()
  (define expr
    '(not (or a (and b c))))

  (define result
    '(and (not a) (or (not b) (not c))))

  (test1 expr result))





(let ()
  (define expr
    '(not (tuple a b)))

  (define result
    '(or (tuple (not a) (and))
         (tuple (and) (not b))))

  (test1 expr result))





(let ()
  (define expr
    '(not (or (tuple a b) c)))

  (define result
    '(and (or (tuple (not a) (and))
              (tuple (and) (not b)))
          (not c)))

  (test1 expr result))




(let ()
  (define expr
    '(not (tuple x)))

  (define result
    '(tuple (not x)))

  (test1 expr result))





(let ()
  (define expr
    '(and a (and b (and (tuple c (tuple d e))
                        (and (or f g)
                             (and h i))))))

  (define result expr)

  (test1 expr result))







(let ()
  (define expr
    '(and a (and b (and (tuple c (tuple d e))
                        (and (or f g)
                             (and h i))))))

  (define result
    '(and a (and b (and (tuple c (tuple d e))
                        (and (or f g)
                             (and h i))))))

  (test1 expr result))




(let ()
  (define expr
    '(not
      (and a (and b (and (tuple c (tuple d e))
                         (and (or f g)
                              (and h i)))))))

  (define result
    '(or (not a)
         (or (not b)
             (or (or (tuple (not c) (and))
                     (tuple (and) (or (tuple (not d) (and))
                                      (tuple (and) (not e)))))
                 (or (and (not f) (not g))
                     (or (not h) (not i)))))))

  (test1 expr result))







(let ()
  (define expr
    '(and a (and b (not (and (tuple c (tuple d e))
                             (and (or f g)
                                  (and h i)))))))

  (define result
    '(and a (and b (or (or (tuple (not c) (and))
                           (tuple (and) (or (tuple (not d) (and))
                                            (tuple (and) (not e)))))
                       (or (and (not f) (not g))
                           (or (not h) (not i)))))))

  (test1 expr result))
