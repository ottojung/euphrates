
(assert= 9 (binary-string->number "1001"))
(assert= 17 (radix-string->number 3 "122"))
(assert= 58 (octal-string->number "72"))
(assert= 1234 (decimal-string->number "1234"))
(assert= 65535 (hexadecimal-string->number "ffff"))
