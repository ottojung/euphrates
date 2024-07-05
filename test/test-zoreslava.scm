
(define (test-serialization)
  (define original
    (zoreslava/p))

  (define duplicate
    (zoreslava:deserialize
     (zoreslava:serialize
      original)))

  (assert (zoreslava:equal? original duplicate)))


(let ()
  (with-zoreslava
   (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5)
   (test-serialization)))

(let ()
  (with-zoreslava
   (zoreslava:set! 'qdtgudtfgpj2ne8fdimxanjg7bdw9ahq 5)
   (zoreslava:set! 'xqomq88lo6limci4lh62n9b4dk5iypgs "hello")
   (zoreslava:set! "shs18cxueebwhz4u41a93bhjdqafk2kl" 'foo)
   (zoreslava:set! 'vrm1ikv4dir8ecox9wyki6uat6e22oh3 'bar)
   (test-serialization)))

(let ()
  (with-zoreslava
   (test-serialization)))


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
   'serialized-object-is-not-list
   (zoreslava:deserialize 5)))
