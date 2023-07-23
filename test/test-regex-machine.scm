
(cond-expand
  (guile)
  ((not guile)
   (import
     (only (euphrates assert-equal-hs) assert=HS))
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates assert) assert))
   (import
     (only (euphrates hashmap)
           hashmap->alist
           hashmap-ref
           make-hashmap))
   (import
     (only (euphrates regex-machine)
           make-regex-machine*))
   (import
     (only (scheme base)
           *
           =
           and
           begin
           cond-expand
           define
           let
           list
           or
           quote))))


;; regex-machine

(let ()

  (let ()
    (define input
      (list "config" "set" "port" "80"))

    (define m (make-regex-machine*
               '(and (= "config" config)
                     (= "set" set)
                     (* (any* <keylist...>))
                     (any <value>))))
    (define H (make-hashmap))
    (assert (m H input))

    (assert=HS
     '((config . "config")
       (set . "set")
       (<keylist...> "port")
       (<value> . "80"))
     (hashmap->alist H)))

  (let ()
    (define input
      (list "config" "set" "port" "real" "one" "80"))

    (define m (make-regex-machine*
               '(and (= "config" config)
                     (= "set" set)
                     (and* (any* <keylist...>))
                     (any <value>))))
    (define H (make-hashmap))
    (assert (m H input))

    (assert=HS
     '((config . "config")
       (set . "set")
       (<keylist...> "port" "real" "one")
       (<value> . "80"))
     (hashmap->alist H)))

  (let ()
    (define input
      (list "config" "set" "port" "real" "one" "80"))

    (define m (make-regex-machine*
               '(and (= "config" config)
                     (= "set" set)
                     (+ (any* <keylist...>))
                     (any <value>))))
    (define H (make-hashmap))
    (assert (m H input))

    (assert=HS
     '((config . "config")
       (set . "set")
       (<keylist...> "port" "real" "one")
       (<value> . "80"))
     (hashmap->alist H)))

  (let ()
    (define input
      (list "set" "port" "80"))

    (define m (make-regex-machine*
               '(and (= "set" set)
                     (any* <keylist...>)
                     (* (any* <keylist...>))
                     (any <value>))))
    (define H (make-hashmap))
    (define match? (m H input))
    (assert match?)

    (assert=HS
     '((set . "set")
       (<keylist...> "port")
       (<value> . "80"))
     (hashmap->alist H)))

  (let ()
    (define input
      (list "config" "set" "port" "80"))

    (define m (make-regex-machine*
               '(and (= "config" config)
                     (= "set" set)
                     (+ (any* <keylist...>))
                     (any <value>))))
    (define H (make-hashmap))
    (m H input)

    (assert=HS
     '((config . "config")
       (set . "set")
       (<keylist...> "port")
       (<value> . "80"))
     (hashmap->alist H)))

  (let ()
    (define m (make-regex-machine*
               '(and (any x z)
                     (or (= 3) (= 2 m k))
                     (and* (any* i))
                     (any y))))
    (define H (make-hashmap))
    (assert (m H (list 1 2 3 9 8 7)))

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 3 9 8))
     (hashmap->alist H)))

  (let ()
    (define m (make-regex-machine*
               '(and (* (any* <group1...>))
                     (* (any* <group2...>)))))
    (define H (make-hashmap))
    (assert (m H (list "a" "b" "c" "d" "e")))
    (assert= (hashmap-ref H '<group1...>)
             (list "a" "b" "c" "d" "e")))

  )
