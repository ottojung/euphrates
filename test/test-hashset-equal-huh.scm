
(assert
 (hashset-equal?
  (list->hashset '(a b c))
  (list->hashset '(a b c))))

(assert
 (hashset-equal?
  (list->hashset '(a b c))
  (list->hashset '(c a b))))

(assert
 (hashset-equal?
  (list->hashset '(a b c))
  (list->hashset '(c b a))))

(assert
 (hashset-equal?
  (list->hashset '(a))
  (list->hashset '(a))))

(assert
 (hashset-equal?
  (list->hashset '())
  (list->hashset '())))

(assert
 (not
  (hashset-equal?
   (list->hashset '(a b c))
   (list->hashset '(d d d)))))

(assert
 (not
  (hashset-equal?
   (list->hashset '(a b c))
   (list->hashset '(d d)))))

(assert
 (not
  (hashset-equal?
   (list->hashset '(a b c))
   (list->hashset '(a b)))))

(assert
 (not
  (hashset-equal?
   (list->hashset '(a))
   (list->hashset '(b)))))

(assert
 (not
  (hashset-equal?
   (list->hashset '(a))
   (list->hashset '()))))

(assert
 (not
  (hashset-equal?
   (list->hashset '())
   (list->hashset '(b)))))
