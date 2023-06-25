
(let ()

  (define object1 -3)

  (define-property absolute set-absolute!)

  (with-properties
   :for-everything

   (assert= (absolute object1 #f) #f)

   (set-absolute! object1 3)

   (assert= (absolute object1 #f) 3)))

(let ()

  (define object1 -3)

  (define-property absolute set-absolute!)

  (with-properties
   :for object1

   (assert= (absolute object1 #f) #f)

   (set-absolute! object1 3)

   (assert= (absolute object1 #f) 3)))

(let ()

  (define object1 -3)
  (define object2 -2)

  (define-property absolute set-absolute!)

  (with-properties
   :for object2

   (assert= (absolute object1 #f) #f)
   (assert= (absolute object2 #f) #f)

   (set-absolute! object2 3)

   (assert= (absolute object1 #f) #f)
   (assert= (absolute object2 #f) 3)))

(let ()
  (define object1 -3)
  (define-property absolute)
  (with-properties
   :for-everything
   (assert= (absolute object1 #f) #f)))

(let ()

  (define object1 -3)
  (define object2 -2)
  (define cought? #f)

  (define-property absolute set-absolute!)

  (with-properties
   :for object2

   (assert= (absolute object1 #f) #f)
   (assert= (absolute object2 #f) #f)

   (set-absolute! object2 3)
   (catchu-case
    (set-absolute! object1 3)
    (('properties-storage-not-initiailized . args)
     (set! cought? #t)))
   (assert cought?)

   (assert= (absolute object1 #f) #f)
   (assert= (absolute object2 #f) 3)))

(let ()

  (define object1 -3)
  (define object2 -2)
  (define cought? #f)

  (define-property absolute set-absolute!)

  (with-properties
   :for object2

   (assert= (absolute object1 #f) #f)
   (assert= (absolute object2 #f) #f)

   (set-absolute! object2 3)
   (catchu-case
    (set-absolute! object1 3)
    (('properties-storage-not-initiailized . args)
     (set! cought? #t)))
   (assert cought?)

   (assert= (absolute object1 #f) #f)
   (assert= (absolute object2 #f) 3))

  (assert= (absolute object1 #f) #f)
  (assert= (absolute object2 #f) #f))

(let ()

  (define object1 -3)
  (define object2 -2)
  (define cought? #f)

  (define-property absolute set-absolute!)

  (with-properties
   :for object2

   (assert= (absolute object1 #f) #f)
   (assert= (absolute object2 #f) #f)

   (set-absolute! object2 3)
   (catchu-case
    (set-absolute! object1 3)
    (('properties-storage-not-initiailized . args)
     (set! cought? #t)))
   (assert cought?)

   (assert= (absolute object1 #f) #f)
   (assert= (absolute object2 #f) 3)

   (with-properties
    :for object2

    (assert= (absolute object1 #f) #f)
    (assert= (absolute object2 #f) #f)

    (set-absolute! object2 3)
    (catchu-case
     (set-absolute! object1 3)
     (('properties-storage-not-initiailized . args)
      (set! cought? #t)))
    (assert cought?)

    (assert= (absolute object1 #f) #f)
    (assert= (absolute object2 #f) 3))))

(let ()

  (define object1 -3)

  (define-property absolute set-absolute!)
  (define-property evenq set-evenq!)

  (with-properties
   :for-everything

   (assert= (absolute object1 #f) #f)
   (assert= (evenq object1 #f) #f)

   (set-absolute! object1 3)

   (assert= (absolute object1 #f) 3)))

(let ()

  (define object1 -3)

  (define-property absolute set-absolute!)
  (define-property evenq set-evenq!)

  (with-properties
   :for-everything

   (assert= (absolute object1 #f) #f)
   (assert= (evenq object1 #f) #f)

   (set-absolute! object1 3)

   (assert= (absolute object1 #f) 3)
   (assert= (evenq object1 #f) #f)))

(let ()

  (define object1 -3)

  (define-property absolute set-absolute!)
  (define-property evenq set-evenq!)

  (with-properties
   :for object1

   (assert= (absolute object1 #f) #f)
   (assert= (evenq object1 #f) #f)

   (set-absolute! object1 3)

   (assert= (absolute object1 #f) 3)
   (assert= (evenq object1 #f) #f)))

(let ()

  (define object1 -3)
  (define object2 -2)

  (define-property absolute set-absolute!)
  (define-property evenq set-evenq!)

  (with-properties
   :for object1

   (assert= (absolute object1 #f) #f)
   (assert= (evenq object1 #f) #f)
   (assert= (absolute object2 #f) #f)
   (assert= (evenq object2 #f) #f)

   (set-absolute! object1 3)

   (assert= (absolute object1 #f) 3)
   (assert= (evenq object1 #f) #f)
   (assert= (absolute object2 #f) #f)
   (assert= (evenq object2 #f) #f)))

(let ()

  (define object1 -3)
  (define object2 -2)

  (define-property absolute set-absolute!)
  (define-property evenq set-evenq!)

  (with-properties
   :for-everything

   (assert= (absolute object1 #f) #f)
   (assert= (evenq object1 #f) #f)
   (assert= (absolute object2 #f) #f)
   (assert= (evenq object2 #f) #f)

   (set-absolute! object1 3)

   (assert= (absolute object1 #f) 3)
   (assert= (evenq object1 #f) #f)
   (assert= (absolute object2 #f) #f)
   (assert= (evenq object2 #f) #f)))

(let ()
  (define object1 -3)

  (define-property absolute)
  (define-property identity-prop set-identity-prop!)

  (with-properties
   :for-everything
   (assert= (absolute object1 #f) #f)
   (assert= (identity-prop object1 #f) #f)

   (set-identity-prop! object1 -3)

   (make-provider
    absolute
    identity-prop
    (lambda (this) (- (identity-prop this))))

   (assert= (absolute object1 #f) 3)
   (assert= (identity-prop object1 #f) -3)

   ))
