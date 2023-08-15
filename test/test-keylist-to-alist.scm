
;; Testing keylist->alist with valid input
(assert= (keylist->alist '(key1: value1 :key2 value2)) '((key1: . value1) (:key2 . value2)))

;; Testing keylist->alist with two consecutive fkeywords
(assert-throw 'type-error (keylist->alist '(key1: key2: value2)))

;; Testing keylist->alist with two consecutive rkeywords
(assert-throw 'type-error (keylist->alist '(:key1 :key2 value2)))

;; Testing keylist->alist with a dangling key at the end
(assert-throw 'type-error (keylist->alist '(key1: value1 key2:)))

;; Testing keylist->alist with non-list input
(assert-throw 'type-error (keylist->alist 'key1:))

;; Valid cases
(assert= (keylist->alist '()) '())
(assert= (keylist->alist '(:key value)) '((:key . value)))
(assert= (keylist->alist '(key1: value1 :key2 value2 key3: value3 :key4 value4)) '((key1: . value1) (:key2 . value2) (key3: . value3) (:key4 . value4)))

;; Cases with two consecutive fkeywords
(assert-throw 'type-error (keylist->alist '(key1: key2:)))
(assert-throw 'type-error (keylist->alist '(key1: value1 key2: key3: value3)))

;; Cases with two consecutive rkeywords
(assert-throw 'type-error (keylist->alist '(:key1 :key2)))
(assert-throw 'type-error (keylist->alist '(:key1 value1 :key2 :key3 value3)))

;; Cases with a mix of consecutive fkeywords and rkeywords
(assert-throw 'type-error (keylist->alist '(key1: :key2 value2)))
(assert-throw 'type-error (keylist->alist '(:key1 key2: value2)))

;; Cases with a dangling key at the end
(assert-throw 'type-error (keylist->alist '(key1: value1 key2:)))
(assert-throw 'type-error (keylist->alist '(:key1 value1 :key2)))

;; Cases with non-list input
(assert-throw 'type-error (keylist->alist 'key1:))
(assert-throw 'type-error (keylist->alist 42))

;; More complex valid cases
(assert (equal? (keylist->alist '(a: 1 :b 2 c: 3 :d 4)) '((a: . 1) (:b . 2) (c: . 3) (:d . 4))))
(assert (equal? (keylist->alist '(x: "apple" :y "banana")) '((x: . "apple") (:y . "banana"))))

;; Mixed cases with symbols and numbers
(assert (equal? (keylist->alist '(:1 "one" :2 "two")) '((:1 . "one") (:2 . "two"))))
(assert (equal? (keylist->alist '(a: 1 :1 "a")) '((a: . 1) (:1 . "a"))))

;; Nested keylists (assuming the function should handle them as values)
(assert (equal? (keylist->alist '(key1: (:nested-key value) key2: "value2")) '((key1: :nested-key value) (key2: . "value2"))))

;; Cases with empty values
(assert (equal? (keylist->alist '(key1: "" :key2 "")) '((key1: . "") (:key2 . ""))))

;; Test with only one unkeyed value
(assert (equal? (keylist->alist '(a)) '((0 . a))))

;; Test with a single unkeyed value 2
(assert= (keylist->alist '(:key1 val1 a))
         '((:key1 . val1) (0 . a)))

;; Test with a single unkeyed value
(assert= (keylist->alist '(:key1 val1 a b c d))
         '((:key1 . val1) (0 . a) (1 . b) (2 . c) (3 . d)))

;; Test with all unkeyed values
(assert= (keylist->alist '(a b c d e))
         '((0 . a) (1 . b) (2 . c) (3 . d) (4 . e)))

;; Test with mixed keyed and unkeyed values
(assert= (keylist->alist '(a key1: val1 b))
         '((0 . a) (key1: . val1) (1 . b)))

;; Test with mixed keyed and unkeyed values 2
(assert= (keylist->alist '(a key1: val1 b key2: val2 c))
         '((0 . a) (key1: . val1) (1 . b) (key2: . val2) (2 . c)))

;; Test with alternating keyed and unkeyed values
(assert= (keylist->alist '(key1: val1 a key2: val2 b key3: val3 c))
         '((key1: . val1) (0 . a) (key2: . val2) (1 . b) (key3: . val3) (2 . c)))

;; Test with nested keylists
(assert= (keylist->alist '(key1: val1 (a b c) key2: val2))
         '((key1: . val1) (0 . (a b c)) (key2: . val2)))

;; ;; Test with numbers as unkeyed values
(assert= (keylist->alist '(1 2 3 4))
         '((0 . 1) (1 . 2) (2 . 3) (3 . 4)))

;; Test with mixed types as unkeyed values
(assert= (keylist->alist '(1 "a" :key "value" (list)))
         '((0 . 1) (1 . "a") (:key . "value") (2 . (list))))
