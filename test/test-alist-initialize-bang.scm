
(cond-expand
  (guile)
  ((not guile)
   (import
     (only (euphrates alist-initialize-bang)
           alist-initialize!
           alist-initialize!:return-multiple
           alist-initialize!:stop))
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (scheme base)
           *
           +
           begin
           cond-expand
           define
           let
           or
           quasiquote
           quote))))



(let ()
  (define state `((X . 3) (Y . 4)))
  (alist-initialize!
   state

   (X 7)
   (Y (+ (X) (X))))

  (assert= state `((X . 7) (Y . 14))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (alist-initialize!
   state

   (Y (+ (X) (X)))
   (X 7)
   )

  (assert= state `((X . 7) (Y . 14))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (alist-initialize! state)
  (assert= state `((X . 3) (Y . 4))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (alist-initialize!
   state

   (X)
   (Y (+ (X) (X)))
   )

  (assert= state `((X . 3) (Y . 6))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (alist-initialize!
   state

   (X 8)
   (Y (+ (X) (X)))
   (Z (+ (Y) (X)))
   )

  (assert= state `((X . 8) (Y . 16) (Z . 24))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (alist-initialize!
   state

   (X 8)
   (Y (+ (X) (X)))
   (Z (alist-initialize!:stop))
   )

  (assert= state `((X . 8) (Y . 16))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (alist-initialize!
   state

   (X 8)
   (Y (alist-initialize!:stop))
   (Z (+ (Y) (X)))
   )

  (assert= state `((X . 8) (Y . 4))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (alist-initialize!
   state

   (X 8)
   (Z (+ (Y) (X)))
   (Y (alist-initialize!:stop))
   )

  (assert= state `((X . 8) (Y . 4))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (alist-initialize!
   state

   (X (+ (Y 'or 2) (Y 'or 7)))
   (Y (+ (X 'or 3) (X 'or 5)))
   )

  (assert= state `((X . 16) (Y . 8))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (alist-initialize!
   state

   (X (+ (Y 'or 2) (Y 'or 7)))
   (Y (+ (X) (X)))
   )

  (assert= state `((X . 9) (Y . 18))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (alist-initialize!
   state

   (Y (+ (X) (X)))
   (X (+ (Y 'or 2) (Y 'or 7)))
   )

  (assert= state `((X . 9) (Y . 18))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (alist-initialize!
   state

   (Y 9)
   (X 7)
   (* (alist-initialize!:return-multiple `((X . 1) (Y . 3))))
   )

  (assert= state `((X . 1) (Y . 3))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (alist-initialize!
   state

   (Y 9)
   (X 7)
   (* (alist-initialize!:return-multiple `((X . 1) (Y . 3) (Z . 5))))
   )

  (assert= state `((X . 1) (Y . 3) (Z . 5))))

(let ()
  (define state `((X . 3) (Y . 4) (M . 8)))
  (alist-initialize!
   state

   (Y 9)
   (X 7)
   (* (alist-initialize!:return-multiple `((X . 1) (Y . 3) (Z . 5))))
   )

  (assert= state `((X . 1) (Y . 3) (M . 8) (Z . 5))))

(let ()
  (define state `((X . 3) (Y . 4) (M . 8)))
  (alist-initialize!
   state

   (Y 9)
   (X 7)
   (* (alist-initialize!:return-multiple `((X . 1) (Y . 3) (Z . 5))))
   (Z 9)
   )

  (assert= state `((X . 1) (Y . 3) (M . 8) (Z . 9))))

(let ()
  (define state `((X . 3) (Y . 4)))
  (alist-initialize! state)
  (assert= state `((X . 3) (Y . 4))))
