
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates general-table) general-table))
   (import
     (only (scheme base)
           +
           begin
           cond-expand
           let
           list
           quasiquote
           quote
           unquote))))


(assert=
 (general-table
  + --------------------------- +
  ! 'key1          ! 1          !
  + --------------------------- +
  ! 'key2          ! 2          !
  + --------------------------- +
  ! 'key3          ! 3          !
  + --------------------------- +
  )

 (list
  '(key1 1)
  '(key2 2)
  '(key3 3)))

(assert=
 (general-table
  + ----------------------------------- +
  ! 'key1          ! 1          !   5   !
  + ----------------------------------- +
  ! 'key2          ! 2          !   6   !
  + ----------------------------------- +
  ! 'key3          ! 3          !   7   !
  + ----------------------------------- +
  )

 (list
  '(key1 1 5)
  '(key2 2 6)
  '(key3 3 7)))

(assert=
 (general-table
  + ----------------------------------- +
  ! 'key1          ! 1          !   5   !
  + ----------------------------------- +
  )

 (list
  '(key1 1 5)))

(assert=
 (general-table
  + -------------- +
  ! 'key1          !
  + -------------- +
  )

 (list
  '(key1)))

(let ((x 1) (y 2) (z 3)
      (a 5) (b 6) (c 7))
  (assert=
   (general-table
    + ----------------------------------- +
    ! 'key1          ! x          !   a   !
    + ----------------------------------- +
    ! 'key2          ! y          !   b   !
    + ----------------------------------- +
    ! 'key3          ! z          !   c   !
    + ----------------------------------- +
    )

   (list
    `(key1 ,x ,a)
    `(key2 ,y ,b)
    `(key3 ,z ,c))))
