
(assert= (fraction->decimal-string (/ 314 100)) "3.14")
(assert= (fraction->decimal-string (/ 355 113)) "3.(1415929203539823008849557522123893805309734513274336283185840707964601769911504424778761061946902654867256637168)")
(assert= (fraction->decimal-string (/ 1 6)) "0.1(6)")
(assert= (fraction->decimal-string (/ 1 2)) "0.5")
(assert= (fraction->decimal-string (/ 2 4)) "0.5")
(assert= (fraction->decimal-string (/ 3 8)) "0.375")
(assert= (fraction->decimal-string (/ 100 7)) "14.(285714)")
(assert= (fraction->decimal-string (/ 455 8)) "56.875")
(assert= (fraction->decimal-string (/ 11 12)) "0.91(6)")
(assert= (fraction->decimal-string (/ 5 14)) "0.3(571428)")
(assert= (fraction->decimal-string (/ 1 17)) "0.(0588235294117647)")
(assert= (fraction->decimal-string (/ 17 5)) "3.4")
(assert= (fraction->decimal-string (/ 83 4)) "20.75")
(assert= (fraction->decimal-string (/ 5 81)) "0.(061728395)")
(assert= (fraction->decimal-string (/ 10 355)) "0.(02816901408450704225352112676056338)")
(assert= (fraction->decimal-string 0) "0")
(assert= (fraction->decimal-string 5) "5")
(assert= (fraction->decimal-string 0.5) "0.5")
(assert= (fraction->decimal-string -2) "-2")
(assert= (fraction->decimal-string (* -1 (/ 314 100))) "-3.14")

(assert= (fraction->decimal-string/tuples 1 2) "0.5")
(assert= (fraction->decimal-string/tuples 2 4) "0.5")
(assert= (fraction->decimal-string/tuples 10 355) "0.(02816901408450704225352112676056338)")

(assert (string-prefix? "0.3333" (fraction->decimal-string (exact->inexact (/ 1 3)))))
(assert (string-prefix? "0.33" (fraction->decimal-string (string->number (number->string (exact->inexact (/ 1 3)))))))
