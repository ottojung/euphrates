
;; Testing alist->keylist with valid input
(assert= (alist->keylist '((key1: . value1) (:key2 . value2)))
         '(key1: value1 :key2 value2))

;; Testing alist->keylist with empty list
(assert= (alist->keylist '()) '())

;; Testing alist->keylist with single key-value pair
(assert= (alist->keylist '((:key . value))) '(:key value))

;; Testing alist->keylist with multiple key-value pairs
(assert= (alist->keylist '((key1: . value1) (:key2 . value2) (key3: . value3) (:key4 . value4))) '(key1: value1 :key2 value2 key3: value3 :key4 value4))

;; Testing alist->keylist with all indexed values
(assert= (alist->keylist '((0 . a) (1 . b) (2 . c) (3 . d) (4 . e))) '(0 a 1 b 2 c 3 d 4 e))


;; Test with all unkeyed values
(assert= (alist->keylist '((0 . a) (1 . b) (2 . c) (3 . d) (4 . e))) '(0 a 1 b 2 c 3 d 4 e))

;; More complex valid cases
(assert= (alist->keylist '((a: . 1) (:b . 2) (c: . 3) (:d . 4))) '(a: 1 :b 2 c: 3 :d 4))

;; Mixed cases with symbols and numbers
(assert= (alist->keylist '((:1 . "one") (:2 . "two"))) '(:1 "one" :2 "two"))

;; Nested keylists
(assert= (alist->keylist '((key1: . (:nested-key value)) (key2: . "value2")))
         '(key1: (:nested-key value) key2: "value2"))

;; Cases with empty values
(assert= (alist->keylist '((key1: . "") (:key2 . ""))) '(key1: "" :key2 ""))

;; Test with only one unkeyed value
(assert= (alist->keylist '((0 . a))) '(0 a))

;; Test with a single unkeyed value 2
(assert= (alist->keylist '((:key1 . val1) (0 . a))) '(:key1 val1 0 a))

;; Test with multiple unkeyed values
(assert= (alist->keylist '((:key1 . val1) (0 . a) (1 . b) (2 . c) (3 . d))) '(:key1 val1 0 a 1 b 2 c 3 d))

;; Test with mixed keyed and unkeyed values
(assert= (alist->keylist '((0 . a) (key1: . val1) (1 . b))) '(0 a key1: val1 1 b))

;; Test with mixed keyed and unkeyed values 2
(assert= (alist->keylist '((0 . a) (key1: . val1) (1 . b) (key2: . val2) (2 . c))) '(0 a key1: val1 1 b key2: val2 2 c))

;; Test with alternating keyed and unkeyed values
(assert= (alist->keylist '((key1: . val1) (0 . a) (key2: . val2) (1 . b) (key3: . val3) (2 . c))) '(key1: val1 0 a key2: val2 1 b key3: val3 2 c))

;; Test with nested keylists
(assert= (alist->keylist '((key1: . val1) (0 . (a b c)) (key2: . val2))) '(key1: val1 0 (a b c) key2: val2))

;; Test with numbers as unkeyed values
(assert= (alist->keylist '((0 . 1) (1 . 2) (2 . 3) (3 . 4))) '(0 1 1 2 2 3 3 4))

;; Test with mixed types as unkeyed values
(assert= (alist->keylist '((0 . 1) (1 . "a") (:key . "value") (2 . (list)))) '(0 1 1 "a" :key "value" 2 (list)))
