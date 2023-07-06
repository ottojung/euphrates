;;;; Copyright (C) 2021, 2022, 2023  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Once upon a time, in the land of Quirkville, there was a jolly bunch of objects
;; who loved to gossip about their ever-changing properties. Properties, my friends,
;; are like the flavors of ice cream that objects get to wear.
;; But here's the twist: just like your mood swings, these properties change over time!
;; Picture a mischievous rubber duck that can magically turn from yellow to polka-dotted purple,
;; making bath time quite the spectacle. Or how about a talking toaster that loves
;; to switch between a British accent and a pirate's growl? And let's not forget the
;; snazzy sneakers that sprout wings every full moon, allowing them to moonwalk
;; across the room. So you see, properties are the zesty spices of an object's life,
;; making them quirky, surprising, and just plain fun!

;; usage:
;; (define object1 (make-unique))
;; (with-properties
;;   :for object1
;;   (define-property size)
;;   (set-property! (size object1) 10)
;;   (size object1) ;; => 10
;;   (size #t) ;; => throws an exception because size is not set for #t
;;   (get-property (size #t) #f) ;; => #f ;; default is #f
;; )

;; note: setter is lazy:
;; (with-properties
;;   :for-everything
;;   (define object1 (make-unique))
;;   (define-property size)
;;   (set-property! (size object1) (begin (display "hello") 10))
;;   ;; does not print anything yet
;;   (size object1) ;; => prints "hello" and returns 10
;;   (size object1) ;; => returns 10 ("hello" is memoized)
;; )


(define-type9 <pproperty>
  (make-pproperty getfn providersin providersou sethook key) pproperty?
  (getfn pproperty-getfn)
  (providersin pproperty-providersin)
  (providersou pproperty-providersou)
  (sethook pproperty-sethook)
  (key pproperty-key)
  )


(define-type9 <pprovider>
  (make-pprovider targets sources evaluator key) pprovider?
  (targets pprovider-targets)
  (sources pprovider-sources)
  (evaluator pprovider-evaluator)
  (key pprovider-key)
  )


(define-type9 <pbox> ;; this is a wrapper for the stored value
  (make-pbox mem evaluated? mtime pmtime) pbox?
  (mem pbox-mem set-pbox-mem!)
  (evaluated? pbox-evaluated? set-pbox-evaluated?!)
  (mtime pbox-mtime set-pbox-mtime!) ;; modification time for this instance of mem
  (pmtime pbox-pmtime set-pbox-pmtime!) ;; possible modification time - i.e. mtime if recalculated
  )


(define properties-current-time 0)
(define properties-advance-time
  (lambda _
    (let* ((current properties-current-time)
           (new (+ 1 current)))
      (set! properties-current-time new)
      new)))


(define properties-getters-map
  (make-hashmap))


(define properties-objmap
  (make-parameter (make-immutable-hashmap)))


(define properties-for-everything?
  (make-parameter #f))


(define properties-everything-key
  (make-unique))


(define not-found-obj
  (make-unique))


(define not-found-storage
  (make-unique))


(define (pbox-value pbox)
  (if (pbox-evaluated? pbox)
      (pbox-mem pbox)
      (let ()
        (define fun (pbox-mem pbox))
        (define new (fun))
        (set-pbox-mem! pbox new)
        (set-pbox-evaluated?! pbox #t)
        new)))


(define (pbox-outdated? pbox)
  (not (equal? (pbox-mtime pbox)
               (pbox-pmtime pbox))))


(define (make-pbox/eager value)
  (define evaluated? #t)
  (define mtime (properties-advance-time))
  (define pmtime mtime)
  (make-pbox value evaluated? mtime pmtime))


(define-syntax make-pbox/lazy
  (syntax-rules ()
    ((_ value)
     (let ()
       (define evaluated? #f)
       (define mtime (properties-advance-time))
       (define pmtime mtime)
       (make-pbox
        (lambda _ value)
        evaluated? mtime pmtime)))))


(define (make-provider/general targets sources evaluator)
  (define target-structs
    (map
      (lambda (target)
        (hashmap-ref properties-getters-map target
                     (raisu 'cannot-find-target-property target)))
      targets))
  (define source-structs
    (map
      (lambda (source)
        (hashmap-ref properties-getters-map source
                     (raisu 'cannot-find-source-property source)))
      sources))

  (define key (make-unique))
  (define ret
    (make-pprovider target-structs
                    source-structs
                    evaluator
                    key))

  (for-each
   (lambda (target-struct)
     (define target-providersin
       (pproperty-providersin target-struct))
     (stack-push! target-providersin ret))
   target-structs)

  (for-each
   (lambda (source-struct)
     (define source-providersou
       (pproperty-providersou source-struct))
     (stack-push! source-providersou ret))
   source-structs)

  ret)


(define (make-provider targets sources evaluator)
  (make-provider/general
   targets sources
   evaluator))


(define-syntax define-provider
  (syntax-rules (:targets :sources)
    ((_ name
        :targets targets
        :sources sources
        evaluator)
     (define name
       (make-provider
        (list . targets) (list . sources)
        evaluator)))))


(define-syntax with-properties
  (syntax-rules (:for :for-everything)
    ((_ :for object . bodies)
     (parameterize
         ((properties-objmap
           (immutable-hashmap-set
            (properties-objmap)
            object (make-hashmap))))
       (let () . bodies)))
    ((_ :for-everything . bodies)
     (parameterize ((properties-for-everything? #t)
                    (properties-objmap
                     (immutable-hashmap-set
                      (properties-objmap)
                      properties-everything-key
                      (make-hashmap))))
       (let () . bodies)))))


(define (storage-not-found-response)
  (raisu 'properties-storage-not-initiailized
         "Storage not initialized. Did you forget to use `with-properties'?"))


(define properties-get-current-objmap
  (let ()
    (define not-found (make-unique))

    (lambda (obj)
      (define global (properties-objmap))
      (define got (immutable-hashmap-ref global obj not-found))
      (if (eq? got not-found)
          (and (properties-for-everything?)
               (let ()
                 (define local
                   (immutable-hashmap-ref
                    global properties-everything-key
                    'impossible-not-found-properties))
                 (define got2 (hashmap-ref local obj not-found))
                 (if (eq? got2 not-found)
                     (let ((new (make-hashmap)))
                       (hashmap-set! local obj new)
                       new)
                     got2)))
          got))))


(define (pprovider-reset! H provider)
  (define vkey (pprovider-key provider))
  (hashmap-delete! H vkey))


(define (pprovider-evaluate H key provider this obj)
  (define ev (pprovider-evaluator provider))
  (define vkey (pprovider-key provider))
  (define ret
    (or (hashmap-ref H vkey #f)
        (call-with-values
            (lambda _ (ev obj))
          (lambda results
            (define maped
              (map make-pbox/eager results))
            (hashmap-set! H vkey maped)
            maped))))

  (if (null? ret)
      (raisu 'provider-did-not-produce-the-promised-value provider)
      (let ()
        (define targets (pprovider-targets provider))

        ;; TODO: optimize indexation
        (define index
          (list-index
           (lambda (x) (eq? this x))
           targets))

        ;; FIXME: check the list length
        (define rbox
          (list-ref ret index))

        (hashmap-set! H key rbox)

        (pbox-mem rbox))))


(define (run-providers this H obj key default)
  (define providers
    (stack->list
     (pproperty-providersin this)))

  (if (null? providers) default
      (let ()
        (define best-provider (car providers))
        (pprovider-evaluate H key best-provider this obj))))


(define (make-property)
  (define property-key (make-unique))
  (define (getfn obj)
    (define H (properties-get-current-objmap obj))
    (if H
        (let ((R (hashmap-ref H property-key #f)))
          (if (and R (not (pbox-outdated? R)))
              (pbox-value R)
              (run-providers
               this H obj property-key
               not-found-obj)))
        not-found-storage))

  (define (get-wrapped obj)
    (define ret (getfn obj))
    (cond
     ((eq? ret not-found-obj)
      (raisu 'object-does-not-have-this-property obj))
     ((eq? ret not-found-storage)
      (storage-not-found-response))
     (else ret)))

  (define providersin (stack-make))
  (define providersou (stack-make))
  (define sethook #f)
  (define this
    (make-pproperty getfn providersin providersou sethook property-key))

  (hashmap-set! properties-getters-map get-wrapped this)

  get-wrapped)


(define-syntax define-property
  (syntax-rules ()
    ((_ getter)
     (define getter (make-property)))))


;; This is just like the usual call to property,
;; but supports default arguments
(define-syntax get-property
  (syntax-rules ()
    ((_ (prop obj)) (prop obj))
    ((_ (prop obj) default)
     (let ()
       (define pprop (hashmap-ref properties-getters-map prop (raisu 'no-getter-initialized getter)))
       (define getfn (pproperty-getfn pprop))
       (define result (getfn obj))
       (if (or (eq? result not-found-obj)
               (eq? result not-found-storage))
           default
           result)))))


(define (traverse-properties-graph/generic forward?)
  (lambda (property-fun provider-fun starting-pprop)
    (define S (make-hashset))
    (define (dive pprop)
      (unless (hashset-has? S pprop)
        (hashset-add! S pprop)
        (when (property-fun pprop)
          (loop pprop))
        (hashset-delete! S pprop)))

    (define (loop pprop)
      (define outs
        (stack->list
         (if forward?
             (pproperty-providersou pprop)
             (pproperty-providersin pprop))))
      (for-each
       (lambda (out)
         (define dependants
           (if forward?
               (pprovider-targets out)
               (pprovider-sources out)))
         (provider-fun out)
         (for-each dive dependants))
       outs))

    (dive starting-pprop)))

(define traverse-properties-graph
  (traverse-properties-graph/generic #t))

(define traverse-properties-graph/reverse
  (traverse-properties-graph/generic #f))

(define (set/unset-property!/fun getter obj evaluator)
  (define pprop (hashmap-ref properties-getters-map getter (raisu 'no-getter-initialized getter)))
  (define H (properties-get-current-objmap obj))

  (define (property-fun p)
    (define property-key (pproperty-key p))
    (if (eq? p pprop)
        (if evaluator
            (hashmap-set! H property-key evaluator)
            (hashmap-delete! H property-key))
        (let ((current (hashmap-ref H property-key #f)))
          (when current
            (set-pbox-pmtime! current 'to-be-determined))))
    #t)

  (define (provider-fun provider)
    (pprovider-reset! H provider))

  (unless H (storage-not-found-response))

  (traverse-properties-graph
   property-fun provider-fun
   pprop))


(define-syntax set-property!
  (syntax-rules ()
    ((_ (getter obj) value)
     (set/unset-property!/fun
      getter obj
      (make-pbox/lazy value)))))


(define-syntax unset-property!
  (syntax-rules ()
    ((_ (getter obj))
     (set/unset-property!/fun getter obj #f))))


(define (outdate-property!/fun getter obj)
  (define pprop (hashmap-ref properties-getters-map getter (raisu 'no-getter-initialized getter)))
  (define H (properties-get-current-objmap obj))

  (define (property-fun p)
    (define property-key (pproperty-key p))
    (define current (hashmap-ref H property-key #f))
    (when current
      (set-pbox-pmtime! current 'to-be-determined))
    #t)

  (define provider-fun (lambda _ (when #f #t)))

  (unless H (storage-not-found-response))

  (traverse-properties-graph
   property-fun provider-fun
   pprop))


(define-syntax outdate-property!
  (syntax-rules ()
    ((_ (getter obj))
     (outdate-property!/fun getter obj))))


(define (mtime->numer x)
  (cond
   ((equal? 'not-evaluatable x) -1)
   ((number? x)
    (if (< x 0)
        (raisu 'mtime-should-not-be-negative x)
        x))
   (else
    (raisu 'bad-mtime-type x))))


(define (get-best-mtime mtimes)
  (list-maximal-element-or
   'not-evaluatable
   mtime->numer
   mtimes))


(define (get-providers-best-mtime/rec dive in)
  (define dependants
    (pprovider-sources in))
  (define mtimes
    (map dive dependants))

  (get-best-mtime mtimes))


(define (get-provider-umtime/optimized provider dive)
  (get-providers-best-mtime/rec dive provider))


(define (get-provider-umtime provider obj)
  (define S (make-hashset))
  (define H (properties-get-current-objmap obj))
  (unless H (storage-not-found-response))
  (define (dive pprop)
    (get-property-umtime/optimized S H pprop obj))
  (get-providers-best-mtime/rec provider dive))


(define (get-property-umtime/optimized S H getter obj)
  (define starting-pprop
    (hashmap-ref properties-getters-map getter (raisu 'no-getter-initialized getter)))
  (define current-time properties-current-time)

  (define (dive pprop)
    (if (hashset-has? S pprop)
        (let ()
          (define property-key (pproperty-key pprop))
          (define pbox (hashmap-ref H property-key #f))
          (define r
            (if pbox (pbox-mtime pbox)
                'not-evaluatable))
          r)
        (begin
          (hashset-add! S pprop)
          (let ((ret (loop pprop)))
            (hashset-delete! S pprop)
            ret))))

  (define (loop pprop)
    (define property-key (pproperty-key pprop))
    (define pbox (hashmap-ref H property-key #f))

    (if (or (not pbox)
            (pbox-outdated? pbox))
        (let ()
          (define ins
            (stack->list
             (pproperty-providersin pprop)))
          (define mtimes
            (map (comp (get-provider-umtime/optimized dive)) ins))
          (get-best-mtime mtimes))

        (pbox-pmtime pbox)))

  (dive starting-pprop))


(define (get-property-umtime getter obj)
  (define S (make-hashset))
  (define H (properties-get-current-objmap obj))
  (unless H (storage-not-found-response))
  (get-property-umtime/optimized S H getter obj))


(define-syntax property-evaluatable?
  (syntax-rules ()
    ((_ (getter obj))
     (let ((pmtime (get-property-umtime getter obj)))
       (and (number? pmtime) pmtime)))))
