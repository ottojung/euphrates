
(cond-expand
 (guile
  (define-module (test-regex-machine)
    :use-module ((euphrates assert-equal-hs) :select (assert=HS))
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates assert) :select (assert))
    :use-module ((euphrates hashmap) :select (hashmap->alist hashmap-ref make-hashmap))
    :use-module ((euphrates regex-machine) :select (make-regex-machine*)))))

;; regex-machine

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
