

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
