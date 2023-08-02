
(assert-throw
 'error-1
 (raisu 'error-1))

(assert-throw
 'error-2
 (raisu 'error-2 'arg1 'arg2))

(assert-throw
 'assertion-fail
 (assert-throw
  'error-2 (+ 1 2)))
