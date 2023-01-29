
(cond-expand
 (guile
  (define-module (test-cfg-machine)
    :use-module ((euphrates assert-equal-hs) :select (assert=HS))
    :use-module ((euphrates assert) :select (assert))
    :use-module ((euphrates cfg-machine) :select (make-cfg-machine))
    :use-module ((euphrates immutable-hashmap) :select (immutable-hashmap->alist)))))

;; cfg-machine

(let ()
  (let ()
    (define m (make-cfg-machine
               '((main (and (any x z)
                            (or (= 3) (= 2 m k))
                            (and* (any* i))
                            (any y))))))
    (define-values (H sucess?) (m (list 1 2 3 9 8 7)))
    (assert sucess?)

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 8 9 3))
     (immutable-hashmap->alist H)))

  (let ()
    (define m (make-cfg-machine
               '((main (and (any x z)
                            (or (= 3) (= 2 m k))
                            (call save-i)
                            (any y)))
                 (save-i (and* (any* i))))))
    (define-values (H sucess?) (m (list 1 2 3 9 8 7)))
    (assert sucess?)

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 8 9 3))
     (immutable-hashmap->alist H)))

  (let ()
    (define m (make-cfg-machine
               '((main (and (any x z)
                            (or (= 3) (= 2 m k))
                            (call save-i)
                            (any y)))
                 (save-i (or (and (any* i) (call save-i))
                             (and (any* i)))))))
    (define-values (H sucess?) (m (list 1 2 3 9 8 7)))
    (assert sucess?)

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 8 9 3))
     (immutable-hashmap->alist H)))

  (let ()
    (define m (make-cfg-machine
               '((main (and (any x z)
                            (or (= 3) (= 2 m k))
                            (call save-i)
                            (any y)))
                 (save-i (or (and (any* i) (call save-i))
                             (epsilon))))))
    (define-values (H sucess?) (m (list 1 2 3 9 8 7)))
    (assert sucess?)

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 8 9 3))
     (immutable-hashmap->alist H)))

  (let ()
    (define m (make-cfg-machine
               '((main (and (any x z)
                            (or (= 3) (= 2 m k))
                            (call save-i)
                            (any y)))
                 (save-i (or (and (any* i) (call save-i))
                             (epsilon))))))
    (define-values (H sucess?) (m (list 1 2 7)))
    (assert sucess?)

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7))
     (immutable-hashmap->alist H)))

  (let ()
    (define m (make-cfg-machine
               '((EUPHRATES-CFG-CLI-MAIN
                  (and (or (= "run" run) (= "let" run) (= "go" run))
                       (? (= "--flag1" --flag1?)))))))
    (define-values (H sucess?) (m (list "go")))
    (assert sucess?)

    (assert=HS
     '((run . "go"))
     (immutable-hashmap->alist H))))
