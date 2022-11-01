
%run guile

;; print-in-window
%use (assert=) "./src/assert-equal.scm"
%use (list-intersperse) "./src/list-intersperse.scm"
%use (print-in-window) "./src/print-in-window.scm"
%use (string->words) "./src/string-to-words.scm"

(let ()
  (assert=
   " the quic
  k brown 
  fox jump
  s over a
   lazy do
  g"
   (with-output-to-string
     (lambda _
       (print-in-window 2 10 1 #\space "the quick brown fox jumps over a lazy dog"))))

  (assert=
   " the 
  quick 
  brown 
  fox 
  jumps 
  over a 
  lazy dog"
   (with-output-to-string
     (lambda _
       (print-in-window 2 10 1 #\space
                        (list-intersperse
                         #\space (string->words "the quick brown fox jumps over a lazy dog")))))))
