
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates list-intersperse)
           list-intersperse))
   (import
     (only (euphrates print-in-frame) print-in-frame))
   (import
     (only (euphrates string-to-words) string->words))
   (import
     (only (euphrates with-output-stringified)
           with-output-stringified))
   (import
     (only (scheme base)
           begin
           cond-expand
           let
           newline))))


;; print-in-frame

(let ()

  (assert=
   "
  ┌──────┐
  │the qu│
  │ick br│
  │own fo│
  │x jump│
  │s over│
  │ a laz│
  │y dog │
  └──────┘"
   (with-output-stringified
     (newline)
     (print-in-frame #t #t 2 10 0 #\space "the quick brown fox jumps over a lazy dog")))

  (assert=
   "
  ┌──────┐
  │the qu│
  │ick br│
  │own fo│
  │x jump│
  │s over│
  │ a laz│
  │y dog │"
   (with-output-stringified
     (newline)
     (print-in-frame #t #f 2 10 0 #\space "the quick brown fox jumps over a lazy dog")))

  (assert=
   "
  │the qu│
  │ick br│
  │own fo│
  │x jump│
  │s over│
  │ a laz│
  │y dog │
  └──────┘"
   (with-output-stringified
     (newline)
     (print-in-frame #f #t 2 10 0 #\space "the quick brown fox jumps over a lazy dog")))

  (assert=
   "
  ┌──────┐
  │the   │
  │quick │
  │brown │
  │fox   │
  │jumps │
  │over a│
  │lazy  │
  │dog   │
  └──────┘"
   (with-output-stringified
     (newline)
     (print-in-frame #t #t 2 10 0
                     #\space
                     (list-intersperse
                      #\space
                      (string->words
                       "the quick brown fox jumps over a lazy dog")))))

  (assert=
   "
  ┌──────┐
  │the   │
  │quick │
  │brown │
  │fox   │
  │jumps │
  │over a│
  │lazy  │
  │dog   │
  └──────┘"
   (with-output-stringified
     (newline)
     (print-in-frame #t #t 2 10 0
                     #\space
                     (list-intersperse
                      #\space
                      (string->words
                       "the quick brown fox jumps over a lazy dog")))))

  (assert=
   "
  ┌──────┐
  │the   │
  │quick │
  │brown │
  │fox ab│
  │cdefya│
  │wbyxnw│
  │oeqe  │
  │jumps │
  │over a│
  │lazy  │
  │dog   │
  └──────┘"
   (with-output-stringified
     (newline)
     (print-in-frame #t #t 2 10 0
                     #\space
                     (list-intersperse
                      #\space
                      (string->words
                       "the quick brown fox abcdefyawbyxnwoeqe jumps over a lazy dog")))))

  (assert=
   "
  ┌──────┐
  │the   │
  │quick │
  │brown │
  │fox   │
  │jumps │
  │over a│
  │lazy  │
  │dog   │"
   (with-output-stringified
     (newline)
     (print-in-frame #t #f 2 10 0
                     #\space
                     (list-intersperse
                      #\space
                      (string->words
                       "the quick brown fox jumps over a lazy dog")))))

  (assert=
   "
  │the   │
  │quick │
  │brown │
  │fox   │
  │jumps │
  │over a│
  │lazy  │
  │dog   │
  └──────┘"
   (with-output-stringified
     (newline)
     (print-in-frame #f #t 2 10 0
                     #\space
                     (list-intersperse
                      #\space
                      (string->words
                       "the quick brown fox jumps over a lazy dog")))))

  (assert=
   "
  │the   │
  │quick │
  │brown │
  │fox   │
  │jumps │
  │over a│
  │lazy  │
  │dog   │"
   (with-output-stringified
     (newline)
     (print-in-frame #f #f 2 10 0
                     #\space
                     (list-intersperse
                      #\space
                      (string->words
                       "the quick brown fox jumps over a lazy dog")))))

  )
