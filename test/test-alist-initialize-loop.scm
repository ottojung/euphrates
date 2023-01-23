
%run guile

%use (alist-initialize-loop) "./src/alist-initialize-loop.scm"
%use (assert=) "./src/assert-equal.scm"

(let ()

  (assert=
   '((X . 3) (Y . 5) (Z . 15))

   (alist-initialize-loop
    (X Y Z)

    :initial
    ((X 3)
     (Y 5))

    :invariant
    ((Z (* (X) (Y))))

    :default
    ((X 7)))))

(let ()

  (assert=
   '((X . 3) (Y . 5) (Z . 15) (W . 11))

   (alist-initialize-loop
    (X Y Z W)

    :initial
    ((X 3)
     (Y 5))

    :invariant
    ((Z (* (X) (Y))))

    :default
    ((X 7)
     (W 11)))))

(let ()

  (assert=
   '((X . 3) (Y . 5) (Z . 15))

   (alist-initialize-loop
    (X Y Z)

    :initial
    ((X 3)
     (Y 5))

    :invariant
    ((Z (* (X) (Y)))))))

(let ()

  (assert=
   '((X . 3) (Y . 5) (Z . 15))

   (alist-initialize-loop
    (X Y Z)

    :initial
    ((X 3)
     (Y 5))

    :default
    ((Z (* (X) (Y)))))))

(let ()

  (assert=
   '((X . 3) (Y . 5) (Z . #f))

   (alist-initialize-loop
    (X Y Z)

    :initial
    ((X 3)
     (Y 5)))))
