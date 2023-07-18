
(cond-expand
  (guile)
  ((not guile)
   (import
     (only (euphrates alist-initialize-loop)
           alist-initialize-loop))
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (scheme base)
           *
           begin
           cond-expand
           let
           quote))))



(let ()

  (assert=
   '((X . 3) (Y . 5) (Z . 15))

   (alist-initialize-loop
    :current alist-name
    :initial
    ((X 3)
     (Y 5))

    :invariant
    ((Z (* (X) (Y))))

    :user
    ((X 7)))))

(let ()

  (assert=
   '((X . 3) (Y . 5) (Z . 15) (W . 11))

   (alist-initialize-loop
    :current alist-name
    :initial
    ((X 3)
     (Y 5))

    :invariant
    ((Z (* (X) (Y))))

    :user
    ((X 7)
     (W 11)))))

(let ()

  (assert=
   '((X . 3) (Y . 5) (Z . 15))

   (alist-initialize-loop
    :current alist-name
    :initial
    ((X 3)
     (Y 5))

    :invariant
    ((Z (* (X) (Y)))))))

(let ()

  (assert=
   '((X . 3) (Y . 5) (Z . 15))

   (alist-initialize-loop
    :current alist-name
    :initial
    ((X 3)
     (Y 5))

    :user
    ((Z (* (X) (Y)))))))

(let ()

  (assert=
   '((X . 3) (Y . 5))

   (alist-initialize-loop
    :current alist-name
    :initial
    ((X 3)
     (Y 5)))))

(let ()

  (assert=
   '((X . 3) (Y . 5))

   (alist-initialize-loop
    :current alist-name
    :invariant
    ((X 3)
     (Y 5)))))

(let ()

  (assert=
   '((X . 3) (Y . 5) (Z . 15))

   (alist-initialize-loop
    :current alist-name
    :initial
    ((X 3)
     (Y 5))

    :invariant
    ((Z (* (X) (Y))))

    :user
    ((X 7)))))
