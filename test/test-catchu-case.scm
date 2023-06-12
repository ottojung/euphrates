


(let () ;; catchu-case

  (define-syntax test
    (syntax-rules ()
      ((_ body)
       (assert=
        "OK: x y z\n"
        (with-output-to-string
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
