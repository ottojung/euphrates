
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates lines-to-string) lines->string))
   (import
     (only (euphrates np-thread-parameterize)
           with-np-thread-env/non-interruptible))
   (import
     (only (euphrates petri-net-parse-profun)
           petri-profun-net))
   (import
     (only (euphrates petri-net-parse)
           petri-lambda-net))
   (import
     (only (euphrates petri) petri-push petri-run))
   (import
     (only (euphrates with-output-stringified)
           with-output-stringified))
   (import
     (only (scheme base)
           apply
           begin
           case
           cond-expand
           define
           else
           lambda
           let
           list
           quasiquote
           quote
           unquote))
   (import (only (scheme write) display))))


;; petri

(define (handler type options)
  (case type
    ((network-finished) (display "Finish\n"))
    (else (display "ERRORS: ") (display options))))

(define (all-tests)

  (let () ;; petrin-lambda-net
    (assert=
     (lines->string
      (list
       "Hello"
       "Bye Robert the Smith!"
       "Finish"
       ""))
     (with-output-stringified
       (petri-run
        'hello handler
        (list
         (petri-lambda-net
          (list (list '(hello . 0) (lambda () (display "Hello\n") (petri-push 'bye "Robert" "Smith")))
                (list '(bye   . 2) (lambda (name surname) (display "Bye ") (display name) (display " the ") (display surname) (display "!\n")))))
         )
        )))

    (assert=
     (lines->string
      (list
       "Finish"
       "Hello"
       "Finish"
       "Bye Robert the Smith!"
       "Finish"
       ""))
     (with-output-stringified
       (petri-run
        'hello handler
        (list
         (petri-lambda-net
          (list (list '(hello . 0) (lambda () (display "Hello\n") (petri-push 'bye "Robert" "Smith")))))
         (petri-lambda-net
          (list (list '(bye   . 2) (lambda (name surname) (display "Bye ") (display name) (display " the ") (display surname) (display "!\n")))))
         )
        )))

    (assert=
     (lines->string
      (list
       "Finish"
       "Hello"
       "Finish"
       "Bye Robert the Smith!"
       "Bye Robert the Rogers!"
       "Bye Bob the Smith!"
       "Bye Bob the Rogers!"
       "Finish"
       ""))
     (with-output-stringified
       (petri-run
        'hello handler
        (list
         (petri-lambda-net
          (list (list '(hello . 0) (lambda () (display "Hello\n") (petri-push 'bye "Robert" "Smith") (petri-push 'bye "Bob" "Rogers")))))
         (petri-lambda-net
          (list (list '(bye   . 2) (lambda (name surname) (display "Bye ") (display name) (display " the ") (display surname) (display "!\n")))))
         )
        )))

    )


  (let () ;; petri-profun-net

    (assert=
     (lines->string
      (list
       "Hello"
       "Bye Robert the Smith!"
       "Finish"
       ""))
     (with-output-stringified
       (petri-run
        'hello handler
        (list
         (petri-profun-net
          `(((hello) (apply ,display "Hello\n") (push "bye" "Robert" "Smith"))
            ((bye NAME SURNAME)
             (apply ,display "Bye ")
             (apply ,display NAME)
             (apply ,display " the ")
             (apply ,display SURNAME)
             (apply ,display "!\n"))))))))

    ;; NOTE: not a list of networks, just a single one
    (assert=
     (lines->string
      (list
       "Hello"
       "Bye Robert the Smith!"
       "Finish"
       ""))
     (with-output-stringified
       (petri-run
        'hello handler
        (petri-profun-net
         `(((hello) (apply ,display "Hello\n") (push "bye" "Robert" "Smith"))
           ((bye NAME SURNAME)
            (apply ,display "Bye ")
            (apply ,display NAME)
            (apply ,display " the ")
            (apply ,display SURNAME)
            (apply ,display "!\n")))))))

    (assert=
     (lines->string
      (list
       "Hello"
       "Bye Robert the Smith!"
       "Finish"
       ""))
     (with-output-stringified
       (petri-run
        'hello handler
        (list
         (petri-profun-net
          `(((hello) (apply ,display "Hello\n") (push "bye" "Robert" "Smith"))
            ((bye NAME SURNAME)
             (print "Bye ~a the ~a!" NAME SURNAME))))))))

    (assert=
     (lines->string
      (list
       "Finish"
       "Hello"
       "Finish"
       "Bye Robert the Smith!"
       "Finish"
       ""))
     (with-output-stringified
       (petri-run
        'hello handler
        (list
         (petri-profun-net
          `(((hello) (apply ,display "Hello\n") (push "bye" "Robert" "Smith"))))
         (petri-profun-net
          `(((bye NAME SURNAME)
             (apply ,display "Bye ")
             (apply ,display NAME)
             (apply ,display " the ")
             (apply ,display SURNAME)
             (apply ,display "!\n"))))))))

    ;; NOTE: Robert was pushed twice, so he is duplicated.
    (assert=
     (lines->string
      (list
       "Hello"
       "Bye Robert the Smith!"
       "Bye Robert the Rogers!"
       "Bye Robert the Smith!"
       "Bye Robert the Rogers!"
       "Finish"
       ""))
     (with-output-stringified
       (petri-run
        'hello handler
        (list
         (petri-profun-net
          `(((name "Robert"))
            ((surname "Smith"))
            ((surname "Rogers"))
            ((hello) (apply ,display "Hello\n") (name N) (surname S) (push "bye" N S))
            ((bye NAME SURNAME)
             (apply ,display "Bye ")
             (apply ,display NAME)
             (apply ,display " the ")
             (apply ,display SURNAME)
             (apply ,display "!\n"))))))))

    ;; NOTE: deduplication enabled
    (assert=
     (lines->string
      (list
       "Hello"
       "Bye Robert the Smith!"
       "Bye Robert the Rogers!"
       "Finish"
       ""))
     (with-output-stringified
       (petri-run
        'hello '((deduplicate)) handler
        (list
         (petri-profun-net
          `(((name "Robert"))
            ((surname "Smith"))
            ((surname "Rogers"))
            ((hello) (apply ,display "Hello\n") (name N) (surname S) (push "bye" N S))
            ((bye NAME SURNAME)
             (apply ,display "Bye ")
             (apply ,display NAME)
             (apply ,display " the ")
             (apply ,display SURNAME)
             (apply ,display "!\n"))))))))

    (assert=
     (lines->string
      (list
       "Finish"
       "Hello"
       "Finish"
       "Bye Robert the Smith!"
       "Bye Robert the Rogers!"
       "Bye Bob the Smith!"
       "Bye Bob the Rogers!"
       "Finish"
       ""))
     (with-output-stringified
       (petri-run
        'hello handler
        (list
         (petri-profun-net
          `(((hello)
             (apply ,display "Hello\n")
             (push "bye" "Robert" "Smith")
             (push "bye" "Bob" "Rogers"))))
         (petri-profun-net
          `(((bye NAME SURNAME)
             (apply ,display "Bye ")
             (apply ,display NAME)
             (apply ,display " the ")
             (apply ,display SURNAME)
             (apply ,display "!\n"))))))))
    )

  (let () ;; mix petri-profun-net and petri-lambda-net

    (assert=
     (lines->string
      (list
       "Finish"
       "Hello"
       "Finish"
       "Bye Robert the Smith!"
       "Bye Robert the Rogers!"
       "Bye Bob the Smith!"
       "Bye Bob the Rogers!"
       "Finish"
       ""))
     (with-output-stringified
       (petri-run
        'hello handler
        (list
         (petri-profun-net
          `(((hello)
             (apply ,display "Hello\n")
             (push "bye" "Robert" "Smith")
             (push "bye" "Bob" "Rogers"))))
         (petri-lambda-net
          (list (list '(bye   . 2) (lambda (name surname) (display "Bye ") (display name) (display " the ") (display surname) (display "!\n")))))
         )
        )))

    (assert=
     (lines->string
      (list
       "Finish"
       "Hello"
       "Finish"
       "Bye Robert the Smith!"
       "Bye Robert the Rogers!"
       "Bye Bob the Smith!"
       "Bye Bob the Rogers!"
       "Finish"
       ""))
     (with-output-stringified
       (petri-run
        'hello handler
        (list
         (petri-lambda-net
          (list (list '(hello . 0) (lambda () (display "Hello\n") (petri-push 'bye "Robert" "Smith") (petri-push 'bye "Bob" "Rogers")))))
         (petri-profun-net
          `(((bye NAME SURNAME)
             (apply ,display "Bye ")
             (apply ,display NAME)
             (apply ,display " the ")
             (apply ,display SURNAME)
             (apply ,display "!\n"))))))))

    )

  )


(with-np-thread-env/non-interruptible
 (all-tests))
