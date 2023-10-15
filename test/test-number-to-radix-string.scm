
(assert= (number->binary-string 9) "1001")
(assert= (number->radix-string 3 17) "122")
(assert= (number->octal-string 58) "72")
(assert= (number->decimal-string 1234) "1234")
(assert= (number->hexadecimal-string 65535) "ffff")
