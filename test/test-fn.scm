
(cond-expand
 (guile
  (define-module (test-fn)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates fn) :select (fn)))))


(let () ;; fn
  (assert= (list 1 2 3)
           ((fn list 1 % 3) 2)))
