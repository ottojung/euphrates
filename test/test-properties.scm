
(let ()

  (define object1 -3)

  (define-property absolute)

  (with-properties
   :for-everything

   (assert= (absolute object1 #f) #f)

   (set-property! (absolute object1) 3)

   (assert= (absolute object1 #f) 3)))

(let ()

  (define object1 -3)

  (define-property absolute)

  (with-properties
   :for object1

   (assert= (absolute object1 #f) #f)

   (set-property! (absolute object1) 3)

   (assert= (absolute object1 #f) 3)))

(let ()

  (define object1 -3)
  (define object2 -2)

  (define-property absolute)

  (with-properties
   :for object2

   (assert= (absolute object1 #f) #f)
   (assert= (absolute object2 #f) #f)

   (set-property! (absolute object2) 3)

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

  (define-property absolute)

  (with-properties
   :for object2

   (assert= (absolute object1 #f) #f)
   (assert= (absolute object2 #f) #f)

   (set-property! (absolute object2) 3)
   (catchu-case
    (set-property! (absolute object1) 3)
    (('properties-storage-not-initiailized . args)
     (set! cought? #t)))
   (assert cought?)

   (assert= (absolute object1 #f) #f)
   (assert= (absolute object2 #f) 3)))

(let ()

  (define object1 -3)
  (define object2 -2)
  (define cought? #f)

  (define-property absolute)

  (with-properties
   :for object2

   (assert= (absolute object1 #f) #f)
   (assert= (absolute object2 #f) #f)

   (set-property! (absolute object2) 3)
   (catchu-case
    (set-property! (absolute object1) 3)
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

  (define-property absolute)

  (with-properties
   :for object2

   (assert= (absolute object1 #f) #f)
   (assert= (absolute object2 #f) #f)

   (set-property! (absolute object2) 3)
   (catchu-case
    (set-property! (absolute object1) 3)
    (('properties-storage-not-initiailized . args)
     (set! cought? #t)))
   (assert cought?)

   (assert= (absolute object1 #f) #f)
   (assert= (absolute object2 #f) 3)

   (with-properties
    :for object2

    (assert= (absolute object1 #f) #f)
    (assert= (absolute object2 #f) #f)

    (set-property! (absolute object2) 3)
    (catchu-case
     (set-property! (absolute object1) 3)
     (('properties-storage-not-initiailized . args)
      (set! cought? #t)))
    (assert cought?)

    (assert= (absolute object1 #f) #f)
    (assert= (absolute object2 #f) 3))))

(let ()

  (define object1 -3)

  (define-property absolute)
  (define-property evenq)

  (with-properties
   :for-everything

   (assert= (absolute object1 #f) #f)
   (assert= (evenq object1 #f) #f)

   (set-property! (absolute object1) 3)

   (assert= (absolute object1 #f) 3)))

(let ()

  (define object1 -3)

  (define-property absolute)
  (define-property evenq)

  (with-properties
   :for-everything

   (assert= (absolute object1 #f) #f)
   (assert= (evenq object1 #f) #f)

   (set-property! (absolute object1) 3)

   (assert= (absolute object1 #f) 3)
   (assert= (evenq object1 #f) #f)))

(let ()

  (define object1 -3)

  (define-property absolute)
  (define-property evenq)

  (with-properties
   :for object1

   (assert= (absolute object1 #f) #f)
   (assert= (evenq object1 #f) #f)

   (set-property! (absolute object1) 3)

   (assert= (absolute object1 #f) 3)
   (assert= (evenq object1 #f) #f)))

(let ()

  (define object1 -3)
  (define object2 -2)

  (define-property absolute)
  (define-property evenq)

  (with-properties
   :for object1

   (assert= (absolute object1 #f) #f)
   (assert= (evenq object1 #f) #f)
   (assert= (absolute object2 #f) #f)
   (assert= (evenq object2 #f) #f)

   (set-property! (absolute object1) 3)

   (assert= (absolute object1 #f) 3)
   (assert= (evenq object1 #f) #f)
   (assert= (absolute object2 #f) #f)
   (assert= (evenq object2 #f) #f)))

(let ()

  (define object1 -3)
  (define object2 -2)

  (define-property absolute)
  (define-property evenq)

  (with-properties
   :for-everything

   (assert= (absolute object1 #f) #f)
   (assert= (evenq object1 #f) #f)
   (assert= (absolute object2 #f) #f)
   (assert= (evenq object2 #f) #f)

   (set-property! (absolute object1) 3)

   (assert= (absolute object1 #f) 3)
   (assert= (evenq object1 #f) #f)
   (assert= (absolute object2 #f) #f)
   (assert= (evenq object2 #f) #f)))

(let ()
  (define object1 -3)

  (define-property absolute)
  (define-property identity-prop)

  (with-properties
   :for-everything
   (assert= (absolute object1 #f) #f)
   (assert= (identity-prop object1 #f) #f)

   (set-property! (identity-prop object1) -3)

   (make-provider
    (list absolute)
    (list identity-prop)
    (lambda (this) (- (identity-prop this))))

   (assert= (absolute object1 #f) 3)
   (assert= (identity-prop object1 #f) -3)

   ))

(let ()
  (define object1 -3)

  (define-property absolute)
  (define-property identity-prop)

  (with-properties
   :for-everything
   (assert= (absolute object1 #f) #f)
   (assert= (identity-prop object1 #f) #f)

   (set-property! (identity-prop object1) -3)

   (make-provider
    (list absolute)
    (list identity-prop)
    (lambda (this) (- (identity-prop this))))

   (assert= (absolute object1 #f) 3)
   (assert= (identity-prop object1 #f) -3)

   (set-property! (identity-prop object1) -5)

   (assert= (absolute object1 #f) 5)
   (assert= (identity-prop object1 #f) -5)

   ))

(let ()
  (define object1 -3)

  (define-property absolute)
  (define-property identity-prop)
  (define-property massive)

  (with-properties
   :for-everything
   (assert= (absolute object1 #f) #f)
   (assert= (massive object1 #f) #f)
   (assert= (identity-prop object1 #f) #f)

   (set-property! (identity-prop object1) -3)

   (make-provider
    (list absolute)
    (list identity-prop)
    (lambda (this) (- (identity-prop this))))

   (make-provider
    (list massive)
    (list absolute)
    (lambda (this) (if (< 4 (absolute this)) 'yes 'no)))

   (assert= (absolute object1 #f) 3)
   (assert= (identity-prop object1 #f) -3)
   (assert= (massive object1 #f) 'no)

   (set-property! (identity-prop object1) -5)

   (assert= (absolute object1 #f) 5)
   (assert= (identity-prop object1 #f) -5)
   (assert= (massive object1 #f) 'yes)

   ))
