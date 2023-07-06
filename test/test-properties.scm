
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Interesting examples towards the end of this file. ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;;   ████████ ██                      ██
;;  ██░░░░░░ ░░              ██████  ░██
;; ░██        ██ ██████████ ░██░░░██ ░██  █████
;; ░█████████░██░░██░░██░░██░██  ░██ ░██ ██░░░██
;; ░░░░░░░░██░██ ░██ ░██ ░██░██████  ░██░███████ ██
;;        ░██░██ ░██ ░██ ░██░██░░░   ░██░██░░░░ ░░
;;  ████████ ░██ ███ ░██ ░██░██      ███░░██████ ██
;; ░░░░░░░░  ░░ ░░░  ░░  ░░ ░░      ░░░  ░░░░░░ ░░
;;

(let ()

  (define object1 -3)

  (define-property absolute)

  (with-properties
   :for-everything

   (assert= (get-property (absolute object1) 'unknown) 'unknown)

   (set-property! (absolute object1) 3)

   (assert= (get-property (absolute object1) 'unknown) 3)))

(let ()

  (define object1 -3)

  (define-property absolute)

  (with-properties
   :for-everything

   (assert= (get-property (absolute object1) 'unknown) 'unknown)

   (set-property! (absolute object1) 3)

   (assert= (absolute object1) 3)))

(let ()

  (define object1 -3)

  (define-property absolute)

  (with-properties
   :for object1

   (assert= (get-property (absolute object1) 'unknown) 'unknown)

   (set-property! (absolute object1) 3)

   (assert= (absolute object1) 3)))

(let ()

  (define object1 -3)
  (define object2 -2)

  (define-property absolute)

  (with-properties
   :for object2

   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (absolute object2) 'unknown) 'unknown)

   (set-property! (absolute object2) 3)

   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (absolute object2) 3)))

(let ()
  (define object1 -3)
  (define-property absolute)
  (with-properties
   :for-everything
   (assert= (get-property (absolute object1) 'unknown) 'unknown)))

(let ()

  (define object1 -3)
  (define object2 -2)
  (define cought? 'unknown)

  (define-property absolute)

  (with-properties
   :for object2

   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (absolute object2) 'unknown) 'unknown)

   (set-property! (absolute object2) 3)
   (catchu-case
    (set-property! (absolute object1) 3)
    (('properties-storage-not-initiailized . args)
     (set! cought? #t)))
   (assert cought?)

   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (absolute object2) 'unknown) 3)))

(let ()

  (define object1 -3)
  (define object2 -2)
  (define cought? 'unknown)

  (define-property absolute)

  (with-properties
   :for object2

   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (absolute object2) 'unknown) 'unknown)

   (set-property! (absolute object2) 3)
   (catchu-case
    (set-property! (absolute object1) 3)
    (('properties-storage-not-initiailized . args)
     (set! cought? #t)))
   (assert cought?)

   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (absolute object2) 'unknown) 3))

  (assert= (get-property (absolute object1) 'unknown) 'unknown)
  (assert= (get-property (absolute object2) 'unknown) 'unknown))

(let ()

  (define object1 -3)
  (define object2 -2)
  (define cought? 'unknown)

  (define-property absolute)

  (with-properties
   :for object2

   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (absolute object2) 'unknown) 'unknown)

   (set-property! (absolute object2) 3)
   (catchu-case
    (set-property! (absolute object1) 3)
    (('properties-storage-not-initiailized . args)
     (set! cought? #t)))
   (assert cought?)

   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (absolute object2) 'unknown) 3)

   (with-properties
    :for object2

    (assert= (get-property (absolute object1) 'unknown) 'unknown)
    (assert= (get-property (absolute object2) 'unknown) 'unknown)

    (set-property! (absolute object2) 3)
    (catchu-case
     (set-property! (absolute object1) 3)
     (('properties-storage-not-initiailized . args)
      (set! cought? #t)))
    (assert cought?)

    (assert= (get-property (absolute object1) 'unknown) 'unknown)
    (assert= (get-property (absolute object2) 'unknown) 3))))

(let ()

  (define object1 -3)

  (define-property absolute)
  (define-property evenq)

  (with-properties
   :for-everything

   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (evenq object1) 'unknown) 'unknown)

   (set-property! (absolute object1) 3)

   (assert= (get-property (absolute object1) 'unknown) 3)))

(let ()

  (define object1 -3)

  (define-property absolute)
  (define-property evenq)

  (with-properties
   :for-everything

   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (evenq object1) 'unknown) 'unknown)

   (set-property! (absolute object1) 3)

   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (evenq object1) 'unknown) 'unknown)))

(let ()

  (define object1 -3)

  (define-property absolute)
  (define-property evenq)

  (with-properties
   :for object1

   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (evenq object1) 'unknown) 'unknown)

   (set-property! (absolute object1) 3)

   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (evenq object1) 'unknown) 'unknown)))

(let ()

  (define object1 -3)
  (define object2 -2)

  (define-property absolute)
  (define-property evenq)

  (with-properties
   :for object1

   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (evenq object1) 'unknown) 'unknown)
   (assert= (get-property (absolute object2) 'unknown) 'unknown)
   (assert= (get-property (evenq object2) 'unknown) 'unknown)

   (set-property! (absolute object1) 3)

   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (evenq object1) 'unknown) 'unknown)
   (assert= (get-property (absolute object2) 'unknown) 'unknown)
   (assert= (get-property (evenq object2) 'unknown) 'unknown)))

(let ()

  (define object1 -3)
  (define object2 -2)

  (define-property absolute)
  (define-property evenq)

  (with-properties
   :for-everything

   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (evenq object1) 'unknown) 'unknown)
   (assert= (get-property (absolute object2) 'unknown) 'unknown)
   (assert= (get-property (evenq object2) 'unknown) 'unknown)

   (set-property! (absolute object1) 3)

   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (evenq object1) 'unknown) 'unknown)
   (assert= (get-property (absolute object2) 'unknown) 'unknown)
   (assert= (get-property (evenq object2) 'unknown) 'unknown)))


;;
;;  ███████                           ██      ██
;; ░██░░░░██                         ░░      ░██
;; ░██   ░██ ██████  ██████  ██    ██ ██     ░██  █████  ██████  ██████
;; ░███████ ░░██░░█ ██░░░░██░██   ░██░██  ██████ ██░░░██░░██░░█ ██░░░░
;; ░██░░░░   ░██ ░ ░██   ░██░░██ ░██ ░██ ██░░░██░███████ ░██ ░ ░░█████  ██
;; ░██       ░██   ░██   ░██ ░░████  ░██░██  ░██░██░░░░  ░██    ░░░░░██░░
;; ░██      ░███   ░░██████   ░░██   ░██░░██████░░██████░███    ██████  ██
;; ░░       ░░░     ░░░░░░     ░░    ░░  ░░░░░░  ░░░░░░ ░░░    ░░░░░░  ░░
;;

(let ()
  (define object1 -3)

  (define-property absolute)
  (define-property small?)

  (with-properties
   :for-everything
   (make-provider
    (list absolute) ;; targets
    (list) ;; sources
    (lambda (this) (if (> 0 this) (- this) this)))

   (assert= (get-property (absolute object1) 'unknown) 3)

   ))

(let ()
  (define object1 -3)

  (define-property absolute)
  (define-property small?)

  (with-properties
   :for-everything
   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (small? object1) 'unknown) 'unknown)

   (set-property! (absolute object1) 3)

   (make-provider
    (list small?)
    (list absolute)
    (lambda (this) (> 5 (absolute this))))

   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (small? object1) 'unknown) #t)

   ))

(let ()
  (define object1 -3)

  (define-property absolute)
  (define-property small?)

  (with-properties
   :for-everything
   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (small? object1) 'unknown) 'unknown)

   (set-property! (absolute object1) 3)

   (make-provider
    (list small?)
    (list absolute)
    (lambda (this) (> 5 (absolute this))))

   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (small? object1) 'unknown) #t)

   (set-property! (absolute object1) 9)

   (assert= (get-property (absolute object1) 'unknown) 9)
   (assert= (get-property (small? object1) 'unknown) #f)

   ))

(let ()
  (define object1 -3)

  (define-property absolute)
  (define-property small?)
  (define-property massive?)

  (with-properties
   :for-everything
   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (massive? object1) 'unknown) 'unknown)
   (assert= (get-property (small? object1) 'unknown) 'unknown)

   (set-property! (absolute object1) 3)

   (make-provider
    (list small?)
    (list absolute)
    (lambda (this) (> 5 (absolute this))))

   (make-provider
    (list massive?)
    (list absolute)
    (lambda (this) (< 8 (absolute this))))

   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (small? object1) 'unknown) #t)
   (assert= (get-property (massive? object1) 'unknown) #f)

   (set-property! (absolute object1) 9)

   (assert= (get-property (absolute object1) 'unknown) 9)
   (assert= (get-property (small? object1) 'unknown) #f)
   (assert= (get-property (massive? object1) 'unknown) #t)

   ))

(let ()
  (define object1 -3)

  (define-property absolute)
  (define-property small?)

  (with-properties
   :for-everything
   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (small? object1) 'unknown) 'unknown)

   (set-property! (absolute object1) 3)

   (make-provider
    (list small?)
    (list absolute)
    (lambda (this) (> 5 (absolute this))))

   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (small? object1) 'unknown) #t)

   ))
