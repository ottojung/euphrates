
(cond-expand
 (guile
  (define-module (test-print-in-window)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates list-intersperse) :select (list-intersperse))
    :use-module ((euphrates print-in-window) :select (print-in-window))
    :use-module ((euphrates string-to-words) :select (string->words)))))

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
