
(assert=
 (recursive-table

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


(let ((x 1) (y 2) (z 3)
      (a 5) (b 6) (c 7))
  (assert=
   (recursive-table
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


(let ()

  (define-syntax $
    (syntax-rules ()
      ((_ row-key)
       (let ()
         (define self
           (or (recursive-table/self/p)
               (raisu* :from "$"
                       :type 'not-inside-recursive-table
                       :message "Called $ not from within a recursive table definition."
                       :args (list row-key))))

         (define matches
           (filter
            (lambda (row)
              (define other-thunk (car row))
              (define other (other-thunk))
              (equal? row-key other))
            self))

         (when (null? matches)
           (raisu* :from "$"
                   :type 'bad-key
                   :message (stringf "Could not find key ~s in the row keys." row-key)
                   :args (list row-key self)))

         (let ()
           (define winner (car matches))
           (define winner-thunk (cadr winner))
           (define winner-value (winner-thunk))
           winner-value)))

      ))

  (assert=
   (recursive-table

    + --------------------------- +
    ! 'key1     ! 1               !
    + --------------------------- +
    ! 'key2     ! (+ ($ 'key3) 5) !
    + --------------------------- +
    ! 'key3     ! 3               !
    + --------------------------- +

    )

   (list
    '(key1 1)
    '(key2 8)
    '(key3 3))))
