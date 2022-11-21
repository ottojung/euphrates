
%run guile

;; immutable-hashmap
%use (assert=) "./src/assert-equal.scm"
%use (make-immutable-hashmap immutable-hashmap-ref immutable-hashmap-set) "./src/immutable-hashmap.scm"

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
