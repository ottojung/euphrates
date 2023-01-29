
(cond-expand
 (guile
  (define-module (test-print-in-frame)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates list-intersperse) :select (list-intersperse))
    :use-module ((euphrates print-in-frame) :select (print-in-frame))
    :use-module ((euphrates string-to-words) :select (string->words)))))

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
   (with-output-to-string
     (lambda _
       (newline)
       (print-in-frame #t #t 2 10 0 #\space "the quick brown fox jumps over a lazy dog"))))

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
   (with-output-to-string
     (lambda _
       (newline)
       (print-in-frame #t #f 2 10 0 #\space "the quick brown fox jumps over a lazy dog"))))

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
   (with-output-to-string
     (lambda _
       (newline)
       (print-in-frame #f #t 2 10 0 #\space "the quick brown fox jumps over a lazy dog"))))

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
   (with-output-to-string
     (lambda _
       (newline)
       (print-in-frame #t #t 2 10 0
                       #\space
                       (list-intersperse
                        #\space
                        (string->words
                         "the quick brown fox jumps over a lazy dog"))))))

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
   (with-output-to-string
     (lambda _
       (newline)
       (print-in-frame #t #t 2 10 0
                       #\space
                       (list-intersperse
                        #\space
                        (string->words
                         "the quick brown fox jumps over a lazy dog"))))))

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
   (with-output-to-string
     (lambda _
       (newline)
       (print-in-frame #t #t 2 10 0
                       #\space
                       (list-intersperse
                        #\space
                        (string->words
                         "the quick brown fox abcdefyawbyxnwoeqe jumps over a lazy dog"))))))

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
   (with-output-to-string
     (lambda _
       (newline)
       (print-in-frame #t #f 2 10 0
                       #\space
                       (list-intersperse
                        #\space
                        (string->words
                         "the quick brown fox jumps over a lazy dog"))))))

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
   (with-output-to-string
     (lambda _
       (newline)
       (print-in-frame #f #t 2 10 0
                       #\space
                       (list-intersperse
                        #\space
                        (string->words
                         "the quick brown fox jumps over a lazy dog"))))))

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
   (with-output-to-string
     (lambda _
       (newline)
       (print-in-frame #f #f 2 10 0
                       #\space
                       (list-intersperse
                        #\space
                        (string->words
                         "the quick brown fox jumps over a lazy dog"))))))

  )
