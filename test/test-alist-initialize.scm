
%run guile

%use (alist-initialize) "./src/alist-initialize.scm"
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
