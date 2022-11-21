
%run guile

;; cfg-machine
%use (assert=HS) "./src/assert-equal-hs.scm"
%use (assert) "./src/assert.scm"
%use (make-cfg-machine) "./src/cfg-machine.scm"
%use (immutable-hashmap->alist) "./src/immutable-hashmap.scm"

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
