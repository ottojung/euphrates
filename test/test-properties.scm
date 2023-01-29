
(cond-expand
 (guile
  (define-module (test-properties)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates properties) :select (define-property)))))

;; properties

(let ()

  (define object1 -3)
  (define-property absolute set-absolute! oRsDeyPCHkSMLSRztojiqnz)

  (assert= (absolute object1 #f) #f)

  (set-absolute! object1 3)

  (assert= (absolute object1 #f) 3))
