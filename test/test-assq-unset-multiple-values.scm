
;; Test with removing multiple keys that exist
(assert=
 '((c . 3))
 (assq-unset-multiple-values '(a b) '((a . 1) (b . 2) (c . 3))))

;; Test with removing some keys that exist and some that don't
(assert=
 '((b . 2) (c . 3))
 (assq-unset-multiple-values '(a d) '((a . 1) (b . 2) (c . 3))))

;; Test with removing keys from an empty list
(assert=
 '()
 (assq-unset-multiple-values '(a b c) '()))

;; Test with removing all keys in the list
(assert=
 '()
 (assq-unset-multiple-values '(a b c) '((a . 1) (b . 2) (c . 3))))

;; Test with an empty list of keys to remove
(assert=
 '((a . 1) (b . 2) (c . 3))
 (assq-unset-multiple-values '() '((a . 1) (b . 2) (c . 3))))

;; Test with multiple occurrences of some keys (shouldn't happen in a well-formed alist, but just in case)
(assert=
 '((c . 3))
 (assq-unset-multiple-values '(a b) '((a . 1) (b . 2) (c . 3) (a . 4) (b . 5))))

;; Test 7: Remove one key that exists and one that doesn't from a single-element list
(assert=
 '()
 (assq-unset-multiple-values '(a d) '((a . 1))))

;; Test 8: Remove one key from a list with duplicate keys
(assert=
 '((b . 2) (b . 2))
 (assq-unset-multiple-values '(a) '((a . 1) (b . 2) (b . 2))))

;; Test 9: Remove multiple keys from a list with duplicate keys
(assert=
 '((a . 1))
 (assq-unset-multiple-values '(b c) '((a . 1) (b . 2) (b . 2) (c . 3))))

;; Test 10: Remove no keys from a list with multiple duplicate keys
(assert=
 '((a . 1) (b . 2) (b . 2) (c . 3))
 (assq-unset-multiple-values '() '((a . 1) (b . 2) (b . 2) (c . 3))))

;; Test 11: Remove all keys from a list with multiple duplicate keys
(assert=
 '()
 (assq-unset-multiple-values '(a b c) '((a . 1) (b . 2) (b . 2) (c . 3))))

;; Test 12: Remove keys that only partially match
(assert=
 '((a1 . 1) (b1 . 2) (c . 3))
 (assq-unset-multiple-values '(a b) '((a1 . 1) (b1 . 2) (c . 3))))

;; Test 13: Remove a single key that exists multiple times
(assert=
 '((b . 2) (c . 3))
 (assq-unset-multiple-values '(a) '((a . 1) (a . 1) (b . 2) (c . 3))))

;; Test 14: Remove multiple keys that exist multiple times
(assert=
 '((c . 3))
 (assq-unset-multiple-values '(a b) '((a . 1) (a . 1) (b . 2) (b . 2) (c . 3))))

;; Test 15: Remove keys from a list with mixed types
(assert=
 '((1 . "one") ("two" . 2))
 (assq-unset-multiple-values '(a b) '((a . 1) (1 . "one") ("two" . 2) (b . 2))))

;; Test 16: Remove keys that don't exist from a list with mixed types
(assert=
 '((a . 1) (1 . "one") ("two" . 2) (b . 2))
 (assq-unset-multiple-values '(c d) '((a . 1) (1 . "one") ("two" . 2) (b . 2))))

;; Test 17: Remove all keys from a list with mixed types
(assert=
 '()
 (assq-unset-multiple-values '(a 1 "two" b) '((a . 1) (1 . "one") ("two" . 2) (b . 2))))

;; Test 18: Remove keys that partially match from a list with mixed types
(assert=
 '((a . 1) (b . 2))
 (assq-unset-multiple-values '(1 "two") '((a . 1) (1 . "one") ("two" . 2) (b . 2))))

;; Test 19: Remove a mix of existing and non-existing keys
(assert=
 '((c . 3) (d . 4))
 (assq-unset-multiple-values '(a b e f) '((a . 1) (b . 2) (c . 3) (d . 4))))

;; Test 20: Remove keys from an alist where all values are the same
(assert=
 '((b . 1) (c . 1))
 (assq-unset-multiple-values '(a d) '((a . 1) (b . 1) (c . 1))))

;; Test 21: Remove all keys from an alist where all values are the same
(assert=
 '()
 (assq-unset-multiple-values '(a b c) '((a . 1) (b . 1) (c . 1))))

;; Test 22: Remove a single existing key from an alist where all keys are the same
(assert=
 '()
 (assq-unset-multiple-values '(a) '((a . 1) (a . 1) (a . 1))))

;; Test 23: Remove keys from an alist with nested alists (shouldn't affect nested alists)
(assert=
 '((a . ((b . 2) (c . 3))) (d . 4))
 (assq-unset-multiple-values '(b c) '((a . ((b . 2) (c . 3))) (d . 4))))

;; Test 24: Remove a key and its nested alist
(assert=
 '((d . 4))
 (assq-unset-multiple-values '(a) '((a . ((b . 2) (c . 3))) (d . 4))))

;; Test 25: Remove keys from an alist with empty alists (shouldn't remove empty alists)
(assert=
 '((a . ()) (b . 2))
 (assq-unset-multiple-values '(c) '((a . ()) (b . 2) (c . 3))))
