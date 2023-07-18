
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates caseq) caseq))
   (import
     (only (scheme base)
           begin
           cond-expand
           else
           let
           quote))))

(let ()

  (assert=
   1
   (caseq 'a ('a 1)))

  (assert=
   2
   (caseq 'a ('b 1) ('a 2)))

  (assert=
   2
   (caseq 'a ('b 1) ('a 2) ('c 3)))

  (assert=
   3
   (caseq 'a ('b 1) ('c 2) (else 3)))

  (let ((a 'a))
    (assert=
     1
     (caseq a ('a 1))))

  (let ((a 'a))
    (assert=
     2
     (caseq a ('b 1) ('a 2) ('c 3))))

  )
