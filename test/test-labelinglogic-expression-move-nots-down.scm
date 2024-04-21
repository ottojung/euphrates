
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
    '(not (list a b)))

  (define result
    '(or (list (not a) (and))
         (list (and) (not b))))

  (test1 expr result))





(let ()
  (define expr
    '(not (or (list a b) c)))

  (define result
    '(and (or (list (not a) (and))
              (list (and) (not b)))
          (not c)))

  (test1 expr result))




(let ()
  (define expr
    '(not (list x)))

  (define result
    '(list (not x)))

  (test1 expr result))





(let ()
  (define expr
    '(and a (and b (and (list c (list d e))
                        (and (or f g)
                             (and h i))))))

  (define result expr)

  (test1 expr result))







(let ()
  (define expr
    '(and a (and b (and (list c (list d e))
                        (and (or f g)
                             (and h i))))))

  (define result
    '(and a (and b (and (list c (list d e))
                        (and (or f g)
                             (and h i))))))

  (test1 expr result))




(let ()
  (define expr
    '(not
      (and a (and b (and (list c (list d e))
                         (and (or f g)
                              (and h i)))))))

  (define result
    '(or (not a)
         (or (not b)
             (or (or (list (not c) (and))
                     (list (and) (or (list (not d) (and))
                                      (list (and) (not e)))))
                 (or (and (not f) (not g))
                     (or (not h) (not i)))))))

  (test1 expr result))







(let ()
  (define expr
    '(and a (and b (not (and (list c (list d e))
                             (and (or f g)
                                  (and h i)))))))

  (define result
    '(and a (and b (or (or (list (not c) (and))
                           (list (and) (or (list (not d) (and))
                                            (list (and) (not e)))))
                       (or (and (not f) (not g))
                           (or (not h) (not i)))))))

  (test1 expr result))
