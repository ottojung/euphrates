
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates string-to-seconds)
           string->seconds))
   (import (only (scheme base) begin cond-expand))))

(assert= 20 (string->seconds "20s"))
(assert= 80 (string->seconds "1m20s"))
(assert= 20 (string->seconds "20"))
(assert= 9000 (string->seconds "30m2h"))
(assert= 7410 (string->seconds "2h30s3m"))
(assert= 9200 (string->seconds "2.5h20s3m"))
(assert= 9000 (string->seconds "30 minutes and 2 hours"))
(assert= 9000 (string->seconds "  30 minutes   and 2 hours  "))
(assert= 5400 (string->seconds "30 minutes and 1 hour"))
(assert= 9000 (string->seconds "30 minutes and2hours"))
(assert= 9000 (string->seconds "30 MINUTEs and 2 hoUrS"))
(assert= 9015 (string->seconds "30.25 MINUTEs and 2 hoUrS"))
(assert= 9015 (string->seconds "30.25 MINUTEs + 2 hoUrS"))
