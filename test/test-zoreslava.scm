
(define (test-serialization)
  (define original
    (zoreslava/p))

  (define duplicate
    (zoreslava:deserialize
     (zoreslava:serialize
      original)))

  (define eq-huh
    (zoreslava:equal? original duplicate))

  (unless eq-huh
    (debugs original)
    (debugs (zoreslava:serialize original))
    (debugs duplicate)
    )

  (assert eq-huh))


(let ()
  (with-zoreslava
   (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5)
   (test-serialization)))

(let ()
  (with-zoreslava
   (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5)
   (zoreslava:set! 'xqomq88lo6limci4lh62n9b4dk5iypgs "hello")
   (test-serialization)))

(let ()
  (with-zoreslava
   (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5)
   (zoreslava:set! 'xqomq88lo6limci4lh62n9b4dk5iypgs "hello")
   (zoreslava:set! "shs18cxueebwhz4u41a93bhjdqafk2kl" ''foo)
   (zoreslava:set! 'vrm1ikv4dir8ecox9wyki6uat6e22oh3 ''bar)
   (test-serialization)))

(let ()
  (with-zoreslava
   (test-serialization)))

(let ()
  (assert
   (zoreslava:equal?
    (with-zoreslava)
    (with-zoreslava))))

(let ()
  (define struct
    (with-zoreslava
     (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5)
     (zoreslava:set! 'xqomq88lo6limci4lh62n9b4dk5iypgs "hello")))

  (assert= 5 (zoreslava:ref struct 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq)))


(let ()
  (define struct
    (with-zoreslava
     (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5)
     (zoreslava:set! 'xqomq88lo6limci4lh62n9b4dk5iypgs "hello")))

  (assert= 5 (zoreslava:ref struct "qdtgudtfgpj2ne8fdimxanjg7bdw9ahq"))
  (assert= "hello" (zoreslava:ref struct "xqomq88lo6limci4lh62n9b4dk5iypgs")))


(let ()
  ;; Test serialization with nested structures
  (with-zoreslava
    (zoreslava:set! 'nested (with-zoreslava
                              (zoreslava:set! 'inner-key "inner-value")))
    (zoreslava:set! 'outer-key "outer-value")
    (test-serialization)))


(let ()
  ;; Test serialization and deserialization with large number of entries
  (with-zoreslava
    (for-each
      (lambda (i)
        (zoreslava:set! (string->symbol (number->string i))
                        (list i (number->string (+ i 1)))))
      (iota 500))
    (test-serialization)))


(let ()
  ;; Test zoreslava:ref with a default value
  (define struct
    (with-zoreslava
      (zoreslava:set! 'existing-key "value")))

  (assert= "value" (zoreslava:ref struct 'existing-key 'default-value))
  (assert= 'default-value (zoreslava:ref struct 'non-existing-key 'default-value)))


(let ()
  ;; Test zoreslava:write and zoreslava:read directly
  (define struct
    (with-zoreslava
     (zoreslava:set! 'key1 "value1")))

  (with-output-stringified
   (zoreslava:write struct))

  (call-with-input-string
   (with-output-stringified
    (zoreslava:write struct))

   (lambda (port)
     (define read-struct (zoreslava:read port))
     (assert (zoreslava:equal? read-struct struct)))))


(let ()
  ;; Test zoreslava:write and zoreslava:read directly [2]
  (define struct
    (with-zoreslava
     (zoreslava:set! 'key1 "value1")))

  (with-output-stringified
   (zoreslava:write struct))

  (call-with-input-string
   (with-output-stringified
    (zoreslava:write struct))

   (lambda (port)
     (define read-struct (zoreslava:read port))
     (assert (zoreslava:equal? read-struct struct)))))


(let ()
  ;; Test zoreslava:write and zoreslava:read directly [3]
  (define struct
    (with-zoreslava
     (zoreslava:set! 'key1 "value1")
     (zoreslava:set! 'key2 "value2")))

  (with-output-stringified
   (zoreslava:write struct))

  (call-with-input-string
   (with-output-stringified
    (zoreslava:write struct))

   (lambda (port)
     (define read-struct (zoreslava:read port))
     (assert (zoreslava:equal? read-struct struct)))))


(let ()
  ;; Test zoreslava:write and zoreslava:read directly [4]
  (define struct
    (with-zoreslava
      (zoreslava:set! 'key1 "value1")
      (zoreslava:set! 'key2 "value2")
      (zoreslava:set! 'key3 "value2")))

  (with-output-stringified
   (zoreslava:write struct))

  (call-with-input-string
    (with-output-stringified
     (zoreslava:write struct))

    (lambda (port)
      (define read-struct (zoreslava:read port))
      (assert (zoreslava:equal? read-struct struct)))))


(let ()
  ;; Test an empty key as a string
  (with-zoreslava
    (define empty-key "")
    (zoreslava:set! empty-key "empty-string-key-value")

    (define struct (zoreslava/p))

    (assert= (zoreslava:ref struct empty-key) "empty-string-key-value")

    (test-serialization)))


(let ()
  ;; Test clear and reset of Zoreslava storage
  (define struct
    (with-zoreslava
      (zoreslava:set! 'key "initial-value")))

  (assert (zoreslava:has? struct 'key))

  (define empty-struct (with-zoreslava 0))

  (assert (not (zoreslava:has? empty-struct 'key))))


(let ()
  ;; Test serialization with special characters in keys
  (with-zoreslava
    (zoreslava:set! 'key-with-hyphen "value1")
    (zoreslava:set! 'key_with_underscore "value2")
    (zoreslava:set! 'keyWithCamelCase "value3")

    (test-serialization)))


(let ()
  (define obj
    (with-zoreslava
     (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5)
     (zoreslava:set! 'xqomq88lo6limci4lh62n9b4dk5iypgs "hello")
     (zoreslava:set! "shs18cxueebwhz4u41a93bhjdqafk2kl" ''foo)
     (zoreslava:set! 'vrm1ikv4dir8ecox9wyki6uat6e22oh3 '(lambda (x) (* x x)))))

  (assert= 5 (zoreslava:ref obj 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq))
  (assert= "hello" (zoreslava:ref obj 'xqomq88lo6limci4lh62n9b4dk5iypgs))
  (assert= ''foo (zoreslava:ref obj "shs18cxueebwhz4u41a93bhjdqafk2kl"))
  (assert= '(lambda (x) (* x x)) (zoreslava:ref obj 'vrm1ikv4dir8ecox9wyki6uat6e22oh3))

  (let ()
    (define serialized (zoreslava:serialize obj))
    (define evaled (zoreslava:eval serialized))

    (assert= 5 (zoreslava:ref evaled 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq))
    (assert= "hello" (zoreslava:ref evaled 'xqomq88lo6limci4lh62n9b4dk5iypgs))
    (assert= 'foo (zoreslava:ref evaled "shs18cxueebwhz4u41a93bhjdqafk2kl"))
    (assert (procedure? (zoreslava:ref evaled 'vrm1ikv4dir8ecox9wyki6uat6e22oh3)))

    0))


(let ()
  (define path
    (append-posix-path "/" "tmp" "zoreslava1.lisp"))

  (define obj
    (with-zoreslava
     (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5)
     (zoreslava:set! 'xqomq88lo6limci4lh62n9b4dk5iypgs "hello")
     (zoreslava:set! "shs18cxueebwhz4u41a93bhjdqafk2kl" ''foo)
     (zoreslava:set! 'vrm1ikv4dir8ecox9wyki6uat6e22oh3 '(lambda (x) (* x x)))))

  (assert= 5 (zoreslava:ref obj 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq))
  (assert= "hello" (zoreslava:ref obj 'xqomq88lo6limci4lh62n9b4dk5iypgs))
  (assert= ''foo (zoreslava:ref obj "shs18cxueebwhz4u41a93bhjdqafk2kl"))
  (assert= '(lambda (x) (* x x)) (zoreslava:ref obj 'vrm1ikv4dir8ecox9wyki6uat6e22oh3))

  (call-with-output-file
      path
    (lambda (port)
      (zoreslava:write obj port)))

  (let ()
    (define evaled (zoreslava:load path))

    (assert= 5 (zoreslava:ref evaled 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq))
    (assert= "hello" (zoreslava:ref evaled 'xqomq88lo6limci4lh62n9b4dk5iypgs))
    (assert= 'foo (zoreslava:ref evaled "shs18cxueebwhz4u41a93bhjdqafk2kl"))
    (assert (procedure? (zoreslava:ref evaled 'vrm1ikv4dir8ecox9wyki6uat6e22oh3)))

    0))


;;;;;;;;;;;;;;;;;;;;;
;; Negative cases:
;;

(let ()
  (define struct
    (with-zoreslava
     (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5)
     (zoreslava:set! 'xqomq88lo6limci4lh62n9b4dk5iypgs "hello")))

  (assert-throw
   'key-not-found
   (zoreslava:ref struct 'whatever)))

(let ()
  (assert-throw
   'parameter-not-initialized
   (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5)))

(let ()
  (with-zoreslava
   (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5)
   (zoreslava:set! 'xqomq88lo6limci4lh62n9b4dk5iypgs "hello")

   (assert-throw
    'set-key-bad-type
    (zoreslava:set! '(qdtgudtfgpj2ne8fdimxanjg7bdw9ahq) 5))

   (zoreslava:set! "shs18cxueebwhz4u41a93bhjdqafk2kl" 'foo)
   (test-serialization)))

(let ()
  (with-zoreslava
   (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5)
   (zoreslava:set! 'xqomq88lo6limci4lh62n9b4dk5iypgs "hello")

   (assert-throw
    'already-defined
    (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 9))

   (zoreslava:set! "shs18cxueebwhz4u41a93bhjdqafk2kl" 'foo)
   (test-serialization)))

(let ()
  (with-zoreslava
   (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5)
   (zoreslava:set! 'xqomq88lo6limci4lh62n9b4dk5iypgs "hello")

   (assert-throw
    'already-defined
    (zoreslava:set! "qdtgudtfgpj2ne8fdimxanjg7bdw9ahq" 9))

   (zoreslava:set! "shs18cxueebwhz4u41a93bhjdqafk2kl" 'foo)
   (test-serialization)))

(let ()
  (with-zoreslava
   (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5)
   (zoreslava:set! 'xqomq88lo6limci4lh62n9b4dk5iypgs "hello")

   (assert-throw
    'already-defined
    (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5))

   (zoreslava:set! "shs18cxueebwhz4u41a93bhjdqafk2kl" 'foo)
   (test-serialization)))

(let ()
  (assert-throw
   'serialized-object-bad-format
   (zoreslava:deserialize 5)))
