
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

;;
;; A helper function to test how many times a certain provider has been called.
;;
(define (make-counter)
  (define count -1)
  (lambda _
    (let ((new (+ 1 count)))
      (set! count new)
      new)))

(let ()
  (define object1 -3)

  (define-property absolute)
  (define-property small?)

  (with-properties
   :for-everything
   (define-provider p1
     :targets (absolute)
     :sources ()
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

   (define-provider p1
     :targets (small?)
     :sources (absolute)
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

   (define-provider p1
     :targets (small?)
     :sources (absolute)
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

   (define-provider p1
     :targets (small?)
     :sources (absolute)
     (lambda (this) (> 5 (absolute this))))

   (define-provider p2
     :targets (massive?)
     :sources (absolute)
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

   (define-provider p1
     :targets (small?)
     :sources (absolute)
     (lambda (this) (> 5 (absolute this))))

   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (small? object1) 'unknown) #t)

   ))

;;  ████     ████          ██   ██   ██          ██
;; ░██░██   ██░██         ░██  ░██  ░░  ██████  ░██
;; ░██░░██ ██ ░██ ██   ██ ░██ ██████ ██░██░░░██ ░██  █████
;; ░██ ░░███  ░██░██  ░██ ░██░░░██░ ░██░██  ░██ ░██ ██░░░██
;; ░██  ░░█   ░██░██  ░██ ░██  ░██  ░██░██████  ░██░███████   ██
;; ░██   ░    ░██░██  ░██ ░██  ░██  ░██░██░░░   ░██░██░░░░   ░░
;; ░██        ░██░░██████ ███  ░░██ ░██░██      ███░░██████   ██
;; ░░         ░░  ░░░░░░ ░░░    ░░  ░░ ░░      ░░░  ░░░░░░   ░░


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                           ;;
;;   Setup for more interesting tests later: ;;
;;                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ()
  (define rect "my rectangle 1") ;; a rectangle object

  (define-property width)
  (define-property height)
  (define-property diagonal)
  (define-property area)

  (define-provider common-area-calulator
    :targets (area)
    :sources (width height)
    (lambda (this) (* (width this) (height this))))

  (with-properties
   :for-everything

   (set-property! (width rect) 3)
   (set-property! (height rect) 4)
   (set-property! (diagonal rect) 5)

   (assert= (get-property (width rect) 'unknown) 3)
   (assert= (get-property (height rect) 'unknown) 4)
   (assert= (get-property (diagonal rect) 'unknown) 5)
   (assert= (get-property (area rect) 'unknown) 12)

   ))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                               ;;
;; What if we only have the diagonal and width?  ;;
;;                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ()
  (define rect "my rectangle 1") ;; a rectangle object

  (define-property width)
  (define-property height)
  (define-property diagonal)
  (define-property area)

  (define-provider common-area-calulator
    :targets (area)
    :sources (width height)
    (lambda (this)
      (* (width this) (height this))))

  ;; L^2 = W^2 + H^2
  ;; L^2 - W^2 = H^2
  ;; H^2 = L^2 - W^2
  ;; H = sqrt(L^2 - W^2)
  ;;
  ;; A = W * H
  ;; A = W * sqrt(L^2 - W^2)    <-
  (define-provider diagonal/width-area-calculator
    :targets (area)
    :sources (diagonal width)
    (lambda (this)
      (* (width this)
         (sqrt
          (- (expt (diagonal this) 2)
             (expt (width this) 2))))))

  (with-properties
   :for-everything

   (set-property! (width rect) 3)
   ;; (set-property! (height rect) 4)
   (set-property! (diagonal rect) 5)

   (assert= (get-property (width rect) 'unknown) 3)
   ;; (assert= (get-property (height rect) 'unknown) 4)
   (assert= (get-property (diagonal rect) 'unknown) 5)
   (assert= (get-property (area rect) 'unknown) 12)

   ))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                   ;;
;; Making sure that only the diagonal formula tried to be evaluated: ;;
;;                                                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ()
  (define common-counter (make-counter))
  (define diagonal-counter (make-counter))

  (define rect "my rectangle 1") ;; a rectangle object

  (define-property width)
  (define-property height)
  (define-property diagonal)
  (define-property area)

  (define-provider common-area-calulator
    :targets (area)
    :sources (width height)
    (lambda (this)
      (common-counter)
      (* (width this) (height this))))

  ;; L^2 = W^2 + H^2
  ;; L^2 - W^2 = H^2
  ;; H^2 = L^2 - W^2
  ;; H = sqrt(L^2 - W^2)
  ;;
  ;; A = W * H
  ;; A = W * sqrt(L^2 - W^2)    <-
  (define-provider diagonal/width-area-calculator
    :targets (area)
    :sources (diagonal width)
    (lambda (this)
      (diagonal-counter)

      (* (width this)
         (sqrt
          (- (expt (diagonal this) 2)
             (expt (width this) 2))))))

  (with-properties
   :for-everything

   (set-property! (width rect) 3)
   ;; (set-property! (height rect) 4)
   (set-property! (diagonal rect) 5)

   (assert= (get-property (width rect) 'unknown) 3)
   ;; (assert= (get-property (height rect) 'unknown) 4)
   (assert= (get-property (diagonal rect) 'unknown) 5)
   (assert= (get-property (area rect) 'unknown) 12)

   (assert= (common-counter) 0)
   (assert= (diagonal-counter) 1)

   ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                          ;;
;; What if we only have both the diagonal and width+height? ;;
;;                                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ()
  (define rect "my rectangle 1") ;; a rectangle object

  (define-property width)
  (define-property height)
  (define-property diagonal)
  (define-property area)

  (define-provider common-area-calulator
    :targets (area)
    :sources (width height)
    (lambda (this)
      (* (width this) (height this))))

  ;; L^2 = W^2 + H^2
  ;; L^2 - W^2 = H^2
  ;; H^2 = L^2 - W^2
  ;; H = sqrt(L^2 - W^2)
  ;;
  ;; A = W * H
  ;; A = W * sqrt(L^2 - W^2)    <-
  (define-provider diagonal/width-area-calculator
    :targets (area)
    :sources (diagonal width)
    (lambda (this)
      (* (width this)
         (sqrt
          (- (expt (diagonal this) 2)
             (expt (width this) 2))))))

  (with-properties
   :for-everything

   (set-property! (width rect) 3)
   (set-property! (height rect) 4)
   (set-property! (diagonal rect) 5)

   (assert= (get-property (width rect) 'unknown) 3)
   (assert= (get-property (height rect) 'unknown) 4)
   (assert= (get-property (diagonal rect) 'unknown) 5)
   (assert= (get-property (area rect) 'unknown) 12)

   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                     ;;
;; Hard to tell what happened...       ;;
;;   But it worked!                    ;;
;; Let's see which formulas were used. ;;
;;                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ()
  (define common-counter (make-counter))
  (define diagonal-counter (make-counter))

  (define rect "my rectangle 1") ;; a rectangle object

  (define-property width)
  (define-property height)
  (define-property diagonal)
  (define-property area)

  (define-provider common-area-calulator
    :targets (area)
    :sources (width height)
    (lambda (this)
      (common-counter)

      (* (width this) (height this))))

  ;; L^2 = W^2 + H^2
  ;; L^2 - W^2 = H^2
  ;; H^2 = L^2 - W^2
  ;; H = sqrt(L^2 - W^2)
  ;;
  ;; A = W * H
  ;; A = W * sqrt(L^2 - W^2)    <-
  (define-provider diagonal/width-area-calculator
    :targets (area)
    :sources (diagonal width)
    (lambda (this)
      (diagonal-counter)

      (* (width this)
         (sqrt
          (- (expt (diagonal this) 2)
             (expt (width this) 2))))))

  (with-properties
   :for-everything

   (set-property! (width rect) 3)
   (set-property! (height rect) 4)
   (set-property! (diagonal rect) 5)

   (assert= (get-property (width rect) 'unknown) 3)
   (assert= (get-property (height rect) 'unknown) 4)
   (assert= (get-property (diagonal rect) 'unknown) 5)
   (assert= (get-property (area rect) 'unknown) 12)

   (assert= (common-counter) 0)
   (assert= (diagonal-counter) 1)

   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;; Of course, we can calculate a missing height value from diagonal instead:  ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ()
  (define rect "my rectangle 1") ;; a rectangle object

  (define-property width)
  (define-property height)
  (define-property diagonal)
  (define-property area)

  (define-provider common-area-calulator
    :targets (area)
    :sources (width height)
    (lambda (this)
      (* (width this) (height this))))

  ;; L^2 = W^2 + H^2
  ;; L^2 - W^2 = H^2
  ;; H^2 = L^2 - W^2
  ;; H = sqrt(L^2 - W^2)    <-
  (define-provider diagonal/width-height-calculator
    :targets (height)
    :sources (diagonal width)
    (lambda (this)
      (sqrt
       (- (expt (diagonal this) 2)
          (expt (width this) 2)))))

  (with-properties
   :for-everything

   (set-property! (diagonal rect) 5)
   (set-property! (width rect) 3)
   ;; (set-property! (height rect) 4)

   (assert= (get-property (width rect) 'unknown) 3)
   (assert= (get-property (height rect) 'unknown) 4)
   (assert= (get-property (diagonal rect) 'unknown) 5)
   (assert= (get-property (area rect) 'unknown) 12)

   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                           ;;
;; Now let us check that if the diagonal were to be updated, ;;
;;   the whole thing would be recalculated again:            ;;
;;                                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ()
  (define rect "my rectangle 1") ;; a rectangle object

  (define-property width)
  (define-property height)
  (define-property diagonal)
  (define-property area)

  (define-provider common-area-calulator
    :targets (area)
    :sources (width height)
    (lambda (this)
      (* (width this) (height this))))

  ;; L^2 = W^2 + H^2
  ;; L^2 - W^2 = H^2
  ;; H^2 = L^2 - W^2
  ;; H = sqrt(L^2 - W^2)    <-
  (define-provider diagonal/width-height-calculator
    :targets (height)
    :sources (diagonal width)
    (lambda (this)
      (sqrt
       (- (expt (diagonal this) 2)
          (expt (width this) 2)))))

  (with-properties
   :for-everything

   (set-property! (diagonal rect) 5)
   (set-property! (width rect) 3)
   ;; (set-property! (height rect) 4)

   (assert= (get-property (width rect) 'unknown) 3)
   (assert= (get-property (height rect) 'unknown) 4)
   (assert= (get-property (diagonal rect) 'unknown) 5)
   (assert= (get-property (area rect) 'unknown) 12)

   (set-property! (diagonal rect) 7)

   (assert= (get-property (width rect) 'unknown) 3)
   (assert= (exact (round (get-property (height rect) 'unknown))) 6)
   (assert= (get-property (diagonal rect) 'unknown) 7)
   (assert= (exact (round (get-property (area rect) 'unknown))) 19)

   ))
