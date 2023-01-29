
(cond-expand
 (guile
  (define-module (test-list-partition)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates list-partition) :select (list-partition))
    :use-module ((euphrates range) :select (range)))))


(let () ;; list-partition
  (assert= '((#t 8 6 4 2 0)
             (#f 9 7 5 3 1))
           (list-partition even? (range 10))))
