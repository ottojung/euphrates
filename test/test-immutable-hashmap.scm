
(cond-expand
 (guile
  (define-module (test-immutable-hashmap)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates immutable-hashmap) :select (make-immutable-hashmap immutable-hashmap-ref immutable-hashmap-set)))))

;; immutable-hashmap

(let ()
  (define H (make-immutable-hashmap))
  (define H2 (immutable-hashmap-set H 'a 5))
  (define H3 (immutable-hashmap-set H2 'b 9))
  (define H4 (immutable-hashmap-set H3 'a 7))

  (assert= #f (immutable-hashmap-ref H 'a #f))
  (assert= 5 (immutable-hashmap-ref H2 'a #f))
  (assert= 5 (immutable-hashmap-ref H3 'a #f))
  (assert= 9 (immutable-hashmap-ref H3 'b #f))
  (assert= 7 (immutable-hashmap-ref H4 'a #f))
  (assert= 9 (immutable-hashmap-ref H4 'b #f))
  )
