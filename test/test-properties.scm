
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates assert) assert))
   (import
     (only (euphrates box) box-ref box-set! make-box))
   (import
     (only (euphrates catchu-case) catchu-case))
   (import
     (only (euphrates properties)
           define-property
           define-provider
           get-property
           property-evaluatable?
           set-property!
           unset-property!
           with-properties))
   (import
     (only (scheme base)
           *
           +
           -
           /
           <
           >
           _
           begin
           cond-expand
           define
           exact
           expt
           if
           lambda
           let
           not
           quote
           round
           set!
           values))
   (import (only (scheme inexact) sqrt))))

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

;;
;; A helper function to test how many times a certain provider has been called:
;;
(define (make-counter)
  (make-box 0))

(define (counter-value counter)
  (box-ref counter))

(define (bump counter)
  (box-set! counter (+ 1 (counter-value counter))))

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



;; test that properties are only evaluated once
(let ()
  (define c1 (make-counter))

  (define object1 -3)

  (define-property absolute)
  (define-property small?)

  (with-properties
   :for-everything
   (define-provider p1
     :targets (absolute)
     :sources ()
     (lambda (this)
       (bump c1)
       (if (> 0 this) (- this) this)))

   (assert= 0 (counter-value c1))

   (assert= (get-property (absolute object1) 'unknown) 3)

   (assert= 1 (counter-value c1)) ;; called once

   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (absolute object1) 'unknown) 3)

   (assert= 1 (counter-value c1)) ;; doesn't get called anymore

   (unset-property! (absolute object1))

   (assert= 1 (counter-value c1)) ;; doesn't trigger reevaluation on unset

   (assert= (get-property (absolute object1) 'unknown) 3)

   (assert= 1 (counter-value c1)) ;; even when the property is reset, the provider still remembers last value

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
  (define c1 (make-counter))
  (define c2 (make-counter))

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
     (lambda (this)
       (bump c1)
       (> 5 (absolute this))))

   (define-provider p2
     :targets (massive?)
     :sources (absolute)
     (lambda (this)
       (bump c2)
       (< 8 (absolute this))))

   (assert= 0 (counter-value c1))
   (assert= 0 (counter-value c2))

   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (small? object1) 'unknown) #t)
   (assert= (get-property (massive? object1) 'unknown) #f)

   (assert= 1 (counter-value c1))
   (assert= 1 (counter-value c2))

   (set-property! (absolute object1) 9)

   (assert= 1 (counter-value c1)) ;; Does not get recalculated immediately
   (assert= 1 (counter-value c2)) ;; Similarly not recalculated immediately

   (assert= (get-property (absolute object1) 'unknown) 9)
   (assert= (get-property (small? object1) 'unknown) #f)
   (assert= (get-property (massive? object1) 'unknown) #t)

   (assert= 2 (counter-value c1))
   (assert= 2 (counter-value c2))

   (assert= (get-property (absolute object1) 'unknown) 9)
   (assert= (get-property (small? object1) 'unknown) #f)
   (assert= (get-property (massive? object1) 'unknown) #t)
   (assert= (get-property (absolute object1) 'unknown) 9)
   (assert= (get-property (small? object1) 'unknown) #f)
   (assert= (get-property (massive? object1) 'unknown) #t)
   (assert= (get-property (absolute object1) 'unknown) 9)
   (assert= (get-property (small? object1) 'unknown) #f)
   (assert= (get-property (massive? object1) 'unknown) #t)
   (assert= (get-property (absolute object1) 'unknown) 9)
   (assert= (get-property (small? object1) 'unknown) #f)
   (assert= (get-property (massive? object1) 'unknown) #t)

   (assert= 2 (counter-value c1))
   (assert= 2 (counter-value c2))

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



;; Check evaluatable result
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


   (let ((absolute-ev? (property-evaluatable? (absolute object1))))
     (assert absolute-ev?))

   (let ((small?-ev? (property-evaluatable? (small? object1))))
     (assert small?-ev?))

   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (small? object1) 'unknown) #t)

   ))



;; Corner case: unresolvable mutual recursion
(let ()
  (define object1 -3)

  (define-property absolute)
  (define-property negative)

  (define-provider p1
    :targets (negative)
    :sources (absolute)
    (lambda (this) (- 0 (absolute this))))

  (define-provider p2
    :targets (absolute)
    :sources (negative)
    (lambda (this) (- 0 (negative this))))

  (with-properties
   :for-everything

   (assert (not (property-evaluatable? (absolute object1))))

   (assert= (get-property (absolute object1) 'unknown) 'unknown)
   (assert= (get-property (negative object1) 'unknown) 'unknown)

   (set-property! (absolute object1) 3)

   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (negative object1) 'unknown) -3)

   ))




;; Check updatehook
(let ()
  (define c1 (make-counter))
  (define object1 -3)

  (define-property absolute
    :on-update (lambda _ (bump c1)))

  (with-properties
   :for-everything

   (assert= 0 (counter-value c1))

   (assert= (get-property (absolute object1) 'unknown) 'unknown)

   (assert= 0 (counter-value c1))

   (set-property! (absolute object1) 3)

   (assert= 1 (counter-value c1))

   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (absolute object1) 'unknown) 3)
   (assert= (get-property (absolute object1) 'unknown) 3)

   (assert= 1 (counter-value c1))

   ))



;;
;;  ████     ████          ██   ██   ██          ██
;; ░██░██   ██░██         ░██  ░██  ░░  ██████  ░██
;; ░██░░██ ██ ░██ ██   ██ ░██ ██████ ██░██░░░██ ░██  █████
;; ░██ ░░███  ░██░██  ░██ ░██░░░██░ ░██░██  ░██ ░██ ██░░░██
;; ░██  ░░█   ░██░██  ░██ ░██  ░██  ░██░██████  ░██░███████   ██
;; ░██   ░    ░██░██  ░██ ░██  ░██  ░██░██░░░   ░██░██░░░░   ░░
;; ░██        ░██░░██████ ███  ░░██ ░██░██      ███░░██████   ██
;; ░░         ░░  ░░░░░░ ░░░    ░░  ░░ ░░      ░░░  ░░░░░░   ░░
;;

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

  ;; D^2 = W^2 + H^2
  ;; D^2 - W^2 = H^2
  ;; H^2 = D^2 - W^2
  ;; H = sqrt(D^2 - W^2)
  ;;
  ;; A = W * H
  ;; A = W * sqrt(D^2 - W^2)    <-
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
      (bump common-counter)
      (* (width this) (height this))))

  ;; D^2 = W^2 + H^2
  ;; D^2 - W^2 = H^2
  ;; H^2 = D^2 - W^2
  ;; H = sqrt(D^2 - W^2)
  ;;
  ;; A = W * H
  ;; A = W * sqrt(D^2 - W^2)    <-
  (define-provider diagonal/width-area-calculator
    :targets (area)
    :sources (diagonal width)
    (lambda (this)
      (bump diagonal-counter)

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

   (assert= 0 (counter-value common-counter))
   (assert= 1 (counter-value diagonal-counter))

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

  ;; D^2 = W^2 + H^2
  ;; D^2 - W^2 = H^2
  ;; H^2 = D^2 - W^2
  ;; H = sqrt(D^2 - W^2)
  ;;
  ;; A = W * H
  ;; A = W * sqrt(D^2 - W^2)    <-
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
      (bump common-counter)

      (* (width this) (height this))))

  ;; D^2 = W^2 + H^2
  ;; D^2 - W^2 = H^2
  ;; H^2 = D^2 - W^2
  ;; H = sqrt(D^2 - W^2)
  ;;
  ;; A = W * H
  ;; A = W * sqrt(D^2 - W^2)    <-
  (define-provider diagonal/width-area-calculator
    :targets (area)
    :sources (diagonal width)
    (lambda (this)
      (bump diagonal-counter)

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

   (assert= 0 (counter-value common-counter))
   (assert= 1 (counter-value diagonal-counter))

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

  ;; D^2 = W^2 + H^2
  ;; D^2 - W^2 = H^2
  ;; H^2 = D^2 - W^2
  ;; H = sqrt(D^2 - W^2)    <-
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                           ;;
;; Additionally we can recover both height and width from area and diagonal. ;;
;; There can be two solutions (width is shorter vs width is longer),         ;;
;;  we ignore the second one although it is a valid solution.                ;;
;;                                                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ()
  (define rect "my rectangle 1") ;; a rectangle object

  (define-property width)
  (define-property height)
  (define-property diagonal)
  (define-property area)

  ;; A = W * H
  ;; W = A / H
  ;; D^2 = W^2 + H^2
  ;; D^2 = (A/W)^2 + W^2
  ;; D^2 = A^2 / W^2 + W^2
  ;; D^2 * W^2 = A^2 + W^4        (Multiplied both sides by W^2)
  ;; W^4 - D^2 * W^2 + A^2 = 0    (Rearranged as a polynomial)
  ;; X^2 - D^2 * X   + A^2 = 0    (W^2 -> X)
  ;; X = 0.5 * (D^2 - sqrt(D^4 - 4*A^2))    (Solution #1)
  ;; X = 0.5 * (D^2 + sqrt(D^4 - 4*A^2))    (Solution #2)
  ;; W = sqrt(X)             <-
  (define-provider reverse-area-calulator
    :targets (width height)
    :sources (area diagonal)
    (lambda (this)
      (define D2 (expt (diagonal this) 2))
      (define D4 (expt D2 2))
      (define A2 (expt (area this) 2))
      (define X (* 1/2 (- D2 (sqrt (- D4 (* 4 A2))))))
      (define W (sqrt X))
      (define H (/ (area this) W))
      (values W H)))

  (with-properties
   :for-everything

   (set-property! (diagonal rect) 5)
   (set-property! (area rect) 12)

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

  ;; D^2 = W^2 + H^2
  ;; D^2 - W^2 = H^2
  ;; H^2 = D^2 - W^2
  ;; H = sqrt(D^2 - W^2)    <-
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


;;
;;  ███████                                          ██
;; ░██░░░░██                                        ░░
;; ░██   ░██   █████   █████  ██   ██ ██████  ██████ ██  ██████  ███████
;; ░███████   ██░░░██ ██░░░██░██  ░██░░██░░█ ██░░░░ ░██ ██░░░░██░░██░░░██
;; ░██░░░██  ░███████░██  ░░ ░██  ░██ ░██ ░ ░░█████ ░██░██   ░██ ░██  ░██   ██
;; ░██  ░░██ ░██░░░░ ░██   ██░██  ░██ ░██    ░░░░░██░██░██   ░██ ░██  ░██  ░░
;; ░██   ░░██░░██████░░█████ ░░██████░███    ██████ ░██░░██████  ███  ░██   ██
;; ░░     ░░  ░░░░░░  ░░░░░   ░░░░░░ ░░░    ░░░░░░  ░░  ░░░░░░  ░░░   ░░   ░░
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;; Let's complete our model by adding providers that work in both directions!    ;;
;; For instance, the diagonal is itself can be calculated from depth and height. ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

  ;; D^2 = W^2 + H^2
  ;; D^2 - W^2 = H^2
  ;; H^2 = D^2 - W^2
  ;; H = sqrt(D^2 - W^2)    <-
  (define-provider diagonal/width-height-calculator
    :targets (height)
    :sources (diagonal width)
    (lambda (this)
      (sqrt
       (- (expt (diagonal this) 2)
          (expt (width this) 2)))))

  ;; D^2 = W^2 + H^2
  ;; D   = sqrt(W^2 + H^2)  <-
  (define-provider diagonal-calculator
    :targets (diagonal)
    :sources (width height)
    (lambda (this)
      (sqrt
       (+ (expt (width this) 2)
          (expt (height this) 2)))))

  (with-properties
   :for-everything

   (set-property! (width rect) 3)
   (set-property! (height rect) 4)

   (assert= (get-property (width rect) 'unknown) 3)
   (assert= (get-property (height rect) 'unknown) 4)
   (assert= (get-property (diagonal rect) 'unknown) 5)
   (assert= (get-property (area rect) 'unknown) 12)

   ))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                     ;;
;; As before, check that updates work, even if our model is recursive: ;;
;;                                                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

  ;; D^2 = W^2 + H^2
  ;; D^2 - W^2 = H^2
  ;; H^2 = D^2 - W^2
  ;; H = sqrt(D^2 - W^2)    <-
  (define-provider diagonal/width-height-calculator
    :targets (height)
    :sources (diagonal width)
    (lambda (this)
      (sqrt
       (- (expt (diagonal this) 2)
          (expt (width this) 2)))))

  ;; D^2 = W^2 + H^2
  ;; D   = sqrt(W^2 + H^2)  <-
  (define-provider diagonal-calculator
    :targets (diagonal)
    :sources (width height)
    (lambda (this)
      (sqrt
       (+ (expt (width this) 2)
          (expt (height this) 2)))))

  (with-properties
   :for-everything

   (set-property! (width rect) 3)
   (set-property! (height rect) 4)

   (assert= (get-property (width rect) 'unknown) 3)
   (assert= (get-property (height rect) 'unknown) 4)
   (assert= (get-property (diagonal rect) 'unknown) 5)
   (assert= (get-property (area rect) 'unknown) 12)

   (set-property! (width rect) 5)
   (set-property! (height rect) 12)

   (assert= (get-property (width rect) 'unknown) 5)
   (assert= (get-property (height rect) 'unknown) 12)
   (assert= (get-property (diagonal rect) 'unknown) 13)
   (assert= (get-property (area rect) 'unknown) 60)

   (set-property! (diagonal rect) 7)

   (assert= (get-property (width rect) 'unknown) 5)
   (assert= (exact (round (get-property (height rect) 'unknown))) 5)
   (assert= (get-property (diagonal rect) 'unknown) 7)
   (assert= (exact (round (get-property (area rect) 'unknown))) 24)

   ))
