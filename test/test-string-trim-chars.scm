

;; string-trim-chars

(let* ((s "xxhellokh")
       (tt "hx"))
  (define (test mode) (string-trim-chars s tt mode))

  (assert= "ellokh" (test 'left))
  (assert= "xxhellok" (test 'right))
  (assert= "ellok" (test 'both)))
