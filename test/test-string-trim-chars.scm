
(cond-expand
 (guile
  (define-module (test-string-trim-chars)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates string-trim-chars) :select (string-trim-chars)))))

;; string-trim-chars

(let* ((s "xxhellokh")
       (tt "hx"))
  (define (test mode) (string-trim-chars s tt mode))

  (assert= "ellokh" (test 'left))
  (assert= "xxhellok" (test 'right))
  (assert= "ellok" (test 'both)))
