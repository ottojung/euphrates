
(cond-expand
 (guile
  (define-module (euphrates properties)
    :export (define-property)
    :use-module ((euphrates hashmap) :select (hashmap-ref hashmap-set! make-hashmap))
    :use-module ((euphrates make-unique) :select (make-unique))
    :use-module ((euphrates memconst) :select (memconst))
    :use-module ((euphrates raisu) :select (raisu)))))



;; NOTE:
;; this leaks memory. Only use it for scripts.

;; usage:
;; (define object1 (make-unique))
;; (define-property size set-size! z8C4ZLEXPNH4DqCNjk0g1)
;; (set-size! object1 10)
;; (size object1) ;; => 10
;; (size #t) ;; => throws an exception because size is not set for #t
;; (size #t #f) ;; => #f

;; note: setter is lazy:
;; (define object1 (make-unique))
;; (define-property size set-size! z8C4ZLEXPNH4DqCNjk0g1)
;; (set-size! object1 (begin (display "hello") 10))
;; ;; does not do anything
;; (size object1) ;; => prints "hello" and returns 10
;; (size object1) ;; => returns 10 ("hello" is memoized)

(define-syntax define-property
  (syntax-rules ()
    ((_ getter setter H)
     (begin
       (define H (make-hashmap))
       (define-syntax setter
         (syntax-rules ()
           ((_2 obj value)
            (hashmap-set! H obj (memconst value)))))
       (define getter
         (let ((not-found (make-unique)))
           (case-lambda
            ((obj)
             (let ((R (hashmap-ref H obj not-found)))
               (if (eq? R not-found)
                   (raisu 'object-does-not-have-this-property (quote H) obj)
                   (R))))
            ((obj default)
             (let ((R (hashmap-ref H obj not-found)))
               (if (eq? R not-found)
                   default
                   (R)))))))))))



