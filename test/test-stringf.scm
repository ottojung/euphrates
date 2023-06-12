
(cond-expand
 (guile
  (define-module (test-stringf)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates stringf) :select (stringf))
    )))

(let ()
  (assert= "start 1 2 3 end"
           (stringf "start ~s 2 ~a end"
                    1 3)))
