
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert) assert))
   (import
     (only (euphrates printable-alphabet)
           printable/alphabet))
   (import
     (only (euphrates random-choice) random-choice))
   (import
     (only (scheme base)
           begin
           cond-expand
           equal?
           let
           list->string
           string-length))))



(let () ;; random-choice
  (assert (equal? 5 (string-length (list->string (random-choice 5 printable/alphabet))))))
