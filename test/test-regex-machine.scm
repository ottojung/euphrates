
%run guile

;; regex-machine
%use (assert=HS) "./src/assert-equal-hs.scm"
%use (assert=) "./src/assert-equal.scm"
%use (assert) "./src/assert.scm"
%use (hashmap->alist hashmap-ref make-hashmap) "./src/hashmap.scm"
%use (make-regex-machine*) "./src/regex-machine.scm"

(let ()

  (let ()
    (define m (make-regex-machine*
               '(and (any x z)
                     (or (= 3) (= 2 m k))
                     (and* (any* i))
                     (any y))))
    (define H (make-hashmap))
    (assert (m H (list 1 2 3 9 8 7)))

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 8 9 3))
     (hashmap->alist H)))

  (let ()
    (define m (make-regex-machine*
               '(and (* (any* <group1...>))
                     (* (any* <group2...>)))))
    (define H (make-hashmap))
    (assert (m H (list "a" "b" "c" "d" "e")))
    (assert= (hashmap-ref H '<group1...>)
             '("e" "d" "c" "b" "a")))

  )
