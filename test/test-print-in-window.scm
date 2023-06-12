

;; print-in-window

(let ()
  (assert=
   " the quic
  k brown 
  fox jump
  s over a
   lazy do
  g"
   (with-output-to-string
     (print-in-window 2 10 1 #\space "the quick brown fox jumps over a lazy dog")))

  (assert=
   " the 
  quick 
  brown 
  fox 
  jumps 
  over a 
  lazy dog"
   (with-output-to-string
     (print-in-window 2 10 1 #\space
                      (list-intersperse
                       #\space (string->words "the quick brown fox jumps over a lazy dog"))))))
