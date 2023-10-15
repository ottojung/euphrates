
; Normal operation
(assert= 2 (least-common-multiple 1 2)) ;; lcm of 1 and 2 is 2
(assert= 6 (least-common-multiple 2 3)) ;; lcm of 2 and 3 is 6
(assert= 12 (least-common-multiple 4 6)) ;; lcm of 4 and 6 is 12

; b (the second number) is 0
(assert= 0 (least-common-multiple 5 0)) ;; lcm of any number and 0 is 0

; a (the first number) is 0
(assert= 0 (least-common-multiple 0 7)) ;; lcm of any number and 0 is 0

; Both a and b are 0
(assert= 0 (least-common-multiple 0 0)) ;; lcm of 0 and 0 is 0

; Both a and b are equal
(assert= 9 (least-common-multiple 9 9)) ;; lcm of a number and itself is the number

; Greater common multiple is a * b (numbers are co-prime)
(assert= 221 (least-common-multiple 13 17)) ;; lcm of 13 and 17 is 221

; Negative numbers
(assert= 30 (least-common-multiple -10 -15)) ;; lcm of -10 and -15 is 30
(assert= 12 (least-common-multiple -4 3)) ;; lcm of -4 and 3 is 12

; Invalid inputs
(assert-throw #t (least-common-multiple 1/2 2/3)) ;; only works for integers
(assert-throw #t (least-common-multiple 1 2.5)) ;; only works for integers
(assert-throw #t (least-common-multiple 'a 'b)) ;; invalid types of both arguments
