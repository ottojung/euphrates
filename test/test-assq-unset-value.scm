
;; Test with removing a key that exists
(assert=
 '((a . 1) (c . 3))
 (assq-unset-value 'b '((a . 1) (b . 2) (c . 3))))

;; Test with removing a key that doesn't exist
(assert=
 '((a . 1) (b . 2) (c . 3))
 (assq-unset-value 'd '((a . 1) (b . 2) (c . 3))))

;; Test with an empty list
(assert=
 '()
 (assq-unset-value 'a '()))

;; Test with removing the only key in the list
(assert=
 '()
 (assq-unset-value 'a '((a . 1))))

;; Test with multiple occurrences of the key (shouldn't happen in a well-formed alist, but just in case)
(assert=
 '((a . 1) (c . 3))
 (assq-unset-value 'b '((a . 1) (b . 2) (c . 3) (b . 4))))
