
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates key-value-map)
           key-value-map/list))
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
 (key-value-map/list
  + --------------------------- +
  ! key1          ! 1           !
  + --------------------------- +
  ! key2          ! 2           !
  + --------------------------- +
  ! key3          ! 3           !
  + --------------------------- +
  )

 (list
  '(key1 . 1)
  '(key2 . 2)
  '(key3 . 3)))

(let ((x 1) (y 2) (z 3))
  (assert=
   (key-value-map/list
    + --------------------------- +
    ! key1          ! x           !
    + --------------------------- +
    ! key2          ! y           !
    + --------------------------- +
    ! key3          ! z           !
    + --------------------------- +
    )

   (list
    `(key1 . ,x)
    `(key2 . ,y)
    `(key3 . ,z))))
