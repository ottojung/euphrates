
(cond-expand
 (guile
  (define-module (test-key-value-map)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates key-value-map) :select (key-value-map/list))
    )))

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
