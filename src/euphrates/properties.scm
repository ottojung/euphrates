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


(define properties-getters-map
  (make-hashmap))


(define properties-objmap
  (make-parameter (make-immutable-hashmap)))


(define properties-for-everything?
  (make-parameter #f))


(define properties-everything-key
  (make-unique))


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

(define-type9 <pproperty>
  (make-pproperty getfn key) pproperty?
  (getfn pproperty-getfn)
  (key pproperty-key)
  )

(define (properties-make-setter getter obj evaluator)
  (define pprop (hashmap-ref properties-getters-map getter (raisu 'no-getter-initialized getter)))
  (define define-property-key (pproperty-key pprop))
  (define H (properties-get-current-objmap obj))
  (unless H (storage-not-found-response))
  (hashmap-set! H define-property-key evaluator))

(define (properties-make-getter)
  (define not-found (make-unique))
  (define define-property-key (make-unique))
  (define get
    (case-lambda
     ((obj)
      (let ((H (properties-get-current-objmap obj)))
        (if H
            (let ((R (hashmap-ref H define-property-key not-found)))
              (if (eq? R not-found)
                  (raisu 'object-does-not-have-this-property
                         obj (quote getter) (quote setter))
                  (R)))
            (storage-not-found-response))))
     ((obj default)
      (let ()
        (define H (properties-get-current-objmap obj))
        (if H
            (let ((R (hashmap-ref H define-property-key not-found)))
              (if (eq? R not-found)
                  default
                  (R)))
            default)))))

  (define p
    (make-pproperty get define-property-key))

  (hashmap-set! properties-getters-map get p)

  get)

(define-syntax define-property
  (syntax-rules ()
    ((_ getter setter)
     (begin
       (define getter
         (properties-make-getter))

       (define-syntax setter
         (syntax-rules ()
           ((_2 obj value)
            (properties-make-setter getter obj (memconst value)))))))))
