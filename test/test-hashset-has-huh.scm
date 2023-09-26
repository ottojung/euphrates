
;; Test if hashset contains 'a'
(assert
 (hashset-has?
  (list->hashset '(a b c))
  'a))

;; Test if hashset contains 'c'
(assert
 (hashset-has?
  (list->hashset '(a b c))
  'c))

;; Test if hashset contains 'b'
(assert
 (hashset-has?
  (list->hashset '(a b c))
  'b))

;; Test if hashset contains 'a'
(assert
 (hashset-has?
  (list->hashset '(a))
  'a))

;; Test if empty hashset contains 'a' (should return false)
(assert
 (not
  (hashset-has?
   (list->hashset '())
   'a)))

;; Test if hashset does not contain 'd'
(assert
 (not
  (hashset-has?
   (list->hashset '(a b c))
   'd)))

;; Test if hashset does not contain 'd'
(assert
 (not
  (hashset-has?
   (list->hashset '(a b c))
   'd)))

;; Test if hashset does not contain 'd'
(assert
 (not
  (hashset-has?
   (list->hashset '(a b c))
   'd)))

;; Test if hashset does not contain 'b'
(assert
 (not
  (hashset-has?
   (list->hashset '(a))
   'b)))

;; Test if empty hashset contains 'a' (should return false)
(assert
 (not
  (hashset-has?
   (list->hashset '(a))
   'b)))

;; Test if hashset does not contain 'b'
(assert
 (not
  (hashset-has?
   (list->hashset '())
   'b)))
