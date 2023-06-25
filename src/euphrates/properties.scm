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

;; usage:
;; (define object1 (make-unique))
;; (with-properties
;;   :for object1
;;   (define-property size set-size!)
;;   (set-size! object1 10)
;;   (size object1) ;; => 10
;;   (size #t) ;; => throws an exception because size is not set for #t
;;   (size #t #f) ;; => #f
;; )

;; note: setter is lazy:
;; (define object1 (make-unique))
;; (define-property size set-size! s1)
;; (set-size! object1 (begin (display "hello") 10))
;; ;; does not do anything
;; (size object1) ;; => prints "hello" and returns 10
;; (size object1) ;; => returns 10 ("hello" is memoized)


(define-type9 <pproperty>
  (make-pproperty getfn providers dependants key) pproperty?
  (getfn pproperty-getfn)
  (providers pproperty-providers)
  (dependants pproperty-dependants)
  (key pproperty-key)
  )


(define-type9 <pprovider>
  (make-pprovider targets sources evaluator) pprovider?
  (targets pprovider-targets)
  (sources pprovider-sources)
  (evaluator pprovider-evaluator)
  )


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

  (define ret
    (make-pprovider target-structs
                    source-structs
                    evaluator))

  (for-each
   (lambda (target-struct)
     (define target-providers
       (pproperty-providers target-struct))
     (stack-push! target-providers ret))
   target-structs)

  (for-each
   (lambda (source-struct)
     (define source-dependants
       (pproperty-dependants source-struct))

     (for-each
      (lambda (target-struct)
        (stack-push! source-dependants target-struct))
      target-structs))
   source-structs)

  ret)


(define (make-provider targets sources evaluator)
  (make-provider/general
   targets sources
   (lambda args
     (values (apply evaluator args) #t))))


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


(define (run-providers this H obj key default)
  (define providers
    (stack->list
     (pproperty-providers this)))

  (define first
    (let loop ((rest providers))
      (if (null? rest)
          default
          (let ()
            (define current (car rest))
            (define ev (pprovider-evaluator current))
            (define-values (result evaluated?) (ev obj))
            (if evaluated?
                (begin
                  (hashmap-set! H key (lambda _ result))
                  result)
                (loop (cdr rest)))))))

  first)


(define (make-property)
  (define property-key (make-unique))
  (define (getfn obj)
    (define H (properties-get-current-objmap obj))
    (if H
        (let ((R (hashmap-ref H property-key not-found-obj)))
          (if (eq? R not-found-obj)
              (run-providers
               this H obj property-key
               not-found-obj)
              (R)))
        not-found-storage))

  (define (get-wrapped obj)
    (define ret (getfn obj))
    (cond
     ((eq? ret not-found-obj)
      (raisu 'object-does-not-have-this-property obj (quote getter) (quote setter)))
     ((eq? ret not-found-storage)
      (storage-not-found-response))
     (else ret)))

  (define providers (stack-make))
  (define dependants (stack-make))
  (define this
    (make-pproperty getfn providers dependants property-key))

  (hashmap-set! properties-getters-map get-wrapped this)

  get-wrapped)


(define-syntax define-property
  (syntax-rules ()
    ((_ getter)
     (define getter (make-property)))))


;; This is just like the usual call to property,
;; but support default arguments
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


(define (unset-property!/fun S H dependant obj)
  (define property-key (pproperty-key dependant))
  (unless (hashset-has? S property-key)
    (hashset-add! S property-key)
    (hashmap-delete! H property-key)
    (notify-dependants S H dependant obj)))


(define (notify-dependants S H pprop obj)
  (define dependants
    (stack->list
     (pproperty-dependants pprop)))

  (for-each
   (lambda (dependant)
     (unset-property!/fun S H dependant obj))
   dependants))


(define (set/unset-property!/fun getter obj evaluator)
  (define pprop (hashmap-ref properties-getters-map getter (raisu 'no-getter-initialized getter)))
  (define property-key (pproperty-key pprop))
  (define H (properties-get-current-objmap obj))
  (define S (make-hashset)) ;; for recursion checking
  (unless H (storage-not-found-response))

  (if evaluator
      (hashmap-set! H property-key evaluator)
      (hashmap-delete! H property-key))

  (notify-dependants S H pprop obj))


(define-syntax set-property!
  (syntax-rules ()
    ((_ (getter obj) value)
     (set/unset-property!/fun getter obj (memconst value)))))


(define unset-property!
  (syntax-rules ()
    ((_ (getter obj))
     (let ()
       (set/unset-property!/fun getter obj #f)))))
