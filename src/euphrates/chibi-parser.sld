
(define-library (euphrates chibi-parser)
  (export parse-integer parse-unsigned-integer parse-c-integer
          parse-real parse-complex
          parse-identifier parse-delimited parse-separated parse-records
          parse-space parse-binary-op
          parse-ipv4-address parse-ipv6-address parse-ip-address
          parse-domain parse-common-domain parse-email parse-uri
          char-hex-digit? char-octal-digit?)
  (cond-expand
   (chibi (import (chibi)))
   (guile (import (srfi srfi-14) (scheme base) (scheme file) (scheme char)))
   ((not chibi) (import (srfi 14) (scheme base) (scheme file) (scheme char)))
   (else (import (srfi 14) (scheme base) (scheme file) (scheme char))))
  (cond-expand
   (guile (import (only (guile) include-from-path))
          (begin (include-from-path "euphrates/chibi-parser.scm")))
   (else (include "chibi-parser.scm"))))
