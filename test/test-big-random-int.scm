


(let () ; big-random-int
  (define (cycle1)
    (with-randomizer-seed
     123
     (assert= 9 (big-random-int 10))
     (assert= 8 (big-random-int 10))
     (assert= 2 (big-random-int 10))

     (assert= 0 (big-random-int 2))
     (assert= 0 (big-random-int 2))
     (assert= 1 (big-random-int 2))

     (assert= 0 (big-random-int 1))
     (assert= 0 (big-random-int 1))
     (assert= 0 (big-random-int 1))

     (assert= 421449275033538924883886841671216436255058414365905493574458321671015306577946227221556343096876127508363684089409637481251714480055716703839167036127900898366120950451190052731063792
              (big-random-int 815912371273817237812731872378123781278317823781378123781728310912371273817237812731872378123781278317823781378123781728310912371273817237812731872378123781278317823781378123781728310))
     ))

  (define (cycle2)
    (with-randomizer-seed
     124
     (assert= 7 (big-random-int 10))
     (assert= 4 (big-random-int 10))
     (assert= 8 (big-random-int 10))
     ))

  (cycle1)
  (cycle1)

  (with-randomizer-seed
   999
   (cycle2)
   (cycle1))

  (cycle2)
  (cycle2)

  )
