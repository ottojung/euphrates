
; Normal operation
(assert= 1 (greatest-common-divisor 1 1)) ;; gcd of 1 and 1 is 1
(assert= 3 (greatest-common-divisor 3 6)) ;; gcd of 3 and 6 is 3
(assert= 14 (greatest-common-divisor 42 56)) ;; gcd of 42 and 56 is 14

; b (the second number) is 0
(assert= 5 (greatest-common-divisor 5 0)) ;; gcd of any number and 0 is the number itself

; a (the first number) is 0
(assert= 7 (greatest-common-divisor 0 7)) ;; gcd of any number and 0 is the number itself

; Both a and b are 0
(assert= 0 (greatest-common-divisor 0 0)) ;; gcd of 0 and 0 is 0

; Both a and b are equal
(assert= 9 (greatest-common-divisor 9 9)) ;; gcd of number and itself is the number

; Greater common divisor is 1 (numbers are co-prime)
(assert= 1 (greatest-common-divisor 13 17)) ;; gcd of 13 and 17 is 1

; Negative numbers
(assert= 5 (greatest-common-divisor -10 -15)) ;; gcd of -10 and -15 is 5
(assert= 1 (greatest-common-divisor -4 3)) ;; gcd of -4 and 3 is 1

; Fractions
(assert-throw #t (greatest-common-divisor 2/3 -15)) ;; gcd only works for integers
