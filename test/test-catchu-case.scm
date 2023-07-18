
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates catchu-case) catchu-case))
   (import (only (euphrates dprintln) dprintln))
   (import (only (euphrates raisu) raisu))
   (import
     (only (euphrates with-output-stringified)
           with-output-stringified))
   (import
     (only (scheme base)
           _
           apply
           begin
           cond-expand
           cons
           define-syntax
           let
           quote
           syntax-rules))))



(let () ;; catchu-case

  (define-syntax test
    (syntax-rules ()
      ((_ body)
       (assert=
        "OK: x y z\n"
        (with-output-stringified
          body)))))

  (assert=
   10
   (catchu-case
    10
    (('test-no-exept x y)
     (raisu 'impossible))))

  (test
   (catchu-case
    (raisu 'test-exception-type-1)
    (('test-exception-type-1)
     (dprintln "OK: x y z"))))

  (test
   (catchu-case
    (raisu 'test-exception-type-1 'x 'y 'z)
    (('test-exception-type-1 arg1 . args)
     (apply dprintln (cons "OK: ~s ~s ~s" (cons arg1 args))))))

  (test
   (catchu-case
    (raisu 'test-exception-type-1 'x 'y 'z)

    (('some-bad-exception-type arg1 arg2 arg3)
     (raisu 'bad-catch!))

    (('test-exception-type-1 arg1 . args)
     (apply dprintln (cons "OK: ~s ~s ~s" (cons arg1 args))))

    (('some-bad-exception-type-2 arg1 arg2 arg3)
     (raisu 'bad-catch-2!))))

  )
