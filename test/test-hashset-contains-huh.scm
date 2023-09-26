;; Test if {a, b, c} contains {a, b, c}
(assert
 (hashset-contains?
  (list->hashset '(a b c))
  (list->hashset '(a b c))))

;; Test if {a, b, c} contains {c, a, b}
(assert
 (hashset-contains?
  (list->hashset '(a b c))
  (list->hashset '(c a b))))

;; Test if {a, b, c} contains {c, b, a}
(assert
 (hashset-contains?
  (list->hashset '(a b c))
  (list->hashset '(c b a))))

;; Test if {a} contains {a}
(assert
 (hashset-contains?
  (list->hashset '(a))
  (list->hashset '(a))))

;; Test if {} contains {}
(assert
 (hashset-contains?
  (list->hashset '())
  (list->hashset '())))

;; Test if {a, b, c} does not contain {d, d, d}
(assert
 (not
  (hashset-contains?
   (list->hashset '(a b c))
   (list->hashset '(d d d)))))

;; Test if {a, b, c} does not contain {d, d}
(assert
 (not
  (hashset-contains?
   (list->hashset '(a b c))
   (list->hashset '(d d)))))

;; Test if {a, b, c} contains {a, b}
(assert
 (hashset-contains?
  (list->hashset '(a b c))
  (list->hashset '(a b))))

;; Test if {a} does not contain {b}
(assert
 (not
  (hashset-contains?
   (list->hashset '(a))
   (list->hashset '(b)))))

;; Test if {a} does not contain {}
(assert
 (hashset-contains?
  (list->hashset '(a))
  (list->hashset '())))

;; Test if {} does not contain {b}
(assert
 (not
  (hashset-contains?
   (list->hashset '())
   (list->hashset '(b)))))
