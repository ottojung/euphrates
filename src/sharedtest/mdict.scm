
(define zz (mdict 1 2 3 4))
(printf "call(3) = ~a\n" (zz 3))
(printf "set(3, 5) = ~a\n" (set! (zz) 5))
(define z2 (mass zz 3 99))
(printf "call(3) = ~a\n" (z2 3))
(printf "set(3, 5) = ~a\n" (set! (z2) 5))
(printf "has(3) = ~a\n" (mdict-has? z2 3))
(printf "has(52) = ~a\n" (mdict-has? z2 52))
(printf "keys(z2) = ~a\n" (mdict-keys z2))

