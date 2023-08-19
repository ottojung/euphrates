
(let ()
  (define result
    (with-run-time-estimate
     (when (= 7 (let fib ((n 30))
                  (cond
                   ((= n 1) 1)
                   ((= n 2) 2)
                   (else (+ (fib (- n 1)) (fib (- n 2)))))))
       (display "Wasn't true last time I ran it"))))

  (assert (number? result))
  (assert (< 0 result))
  (assert (inexact? result)))
