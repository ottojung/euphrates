
%run guile

%use (alist-initialize alist-initialize:stop) "./src/alist-initialize.scm"
%use (assert=) "./src/assert-equal.scm"

(let ()
  (define state `((X . 3) (Y . 4)))

  (define inited
    (alist-initialize
     state

     (X 7)
     (Y (+ (X) (X)))))

  (assert= inited `((X . 7) (Y . 14))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (define inited
    (alist-initialize
     state

     (Y (+ (X) (X)))
     (X 7)
     ))

  (assert= inited `((X . 7) (Y . 14))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (define inited
    (alist-initialize state))

  (assert= inited `((X . 3) (Y . 4))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (define inited
    (alist-initialize
     state

     (X)
     (Y (+ (X) (X)))
     ))

  (assert= inited `((X . 3) (Y . 6))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (define inited
    (alist-initialize
     state

     (X 8)
     (Y (+ (X) (X)))
     (Z (+ (Y) (X)))
     ))

  (assert= inited `((X . 8) (Y . 16) (Z . 24))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (define inited
    (alist-initialize
     state

     (X 8)
     (Y (+ (X) (X)))
     (Z (alist-initialize:stop))
     ))

  (assert= inited `((X . 8) (Y . 16))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (define inited
    (alist-initialize
     state

     (X 8)
     (Y (alist-initialize:stop))
     (Z (+ (Y) (X)))
     ))

  (assert= inited `((X . 8) (Y . 4))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (define inited
    (alist-initialize
     state

     (X 8)
     (Z (+ (Y) (X)))
     (Y (alist-initialize:stop))
     ))

  (assert= inited `((X . 8) (Y . 4))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (define inited
    (alist-initialize
     state

     (X (+ (Y 'or 2) (Y 'or 7)))
     (Y (+ (X 'or 3) (X 'or 5)))
     ))

  (assert= inited `((X . 16) (Y . 8))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (define inited
    (alist-initialize
     state

     (X (+ (Y 'or 2) (Y 'or 7)))
     (Y (+ (X) (X)))
     ))

  (assert= inited `((X . 9) (Y . 18))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (define inited
    (alist-initialize
     state

     (Y (+ (X) (X)))
     (X (+ (Y 'or 2) (Y 'or 7)))
     ))

  (assert= inited `((X . 9) (Y . 18))))
