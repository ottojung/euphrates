
(cond-expand
  (guile)
  ((not guile)
   (import
     (only (euphrates assert-called-once)
           assert-called-once
           with-called-once-extent))
   (import (only (euphrates catch-any) catch-any))
   (import
     (only (scheme base)
           +
           _
           and
           begin
           cond-expand
           define
           define-values
           equal?
           lambda
           let
           newline
           set!
           unless
           values))
   (import (only (scheme process-context) exit))
   (import (only (scheme write) display))))

(let ()
  (with-called-once-extent

   (define (fun)
     (assert-called-once)
     (+ 2 2))

   (unless (equal? (fun) 4)
     (display "ERROR: expected 4 for the result")
     (newline)
     (exit 1))))


(let ()
  (with-called-once-extent

   (define (fun)
     (assert-called-once)
     (values 5 (+ 2 2)))

   (define-values (a b) (fun))

   (unless (and (equal? a 5)
                (equal? b 4))
     (display "ERROR: expected 5, 4 for the result")
     (newline)
     (exit 1))))


(let ()
  (define threw? #f)

  (catch-any
   (lambda _
     (define (fun)
       (assert-called-once)
       (+ 3 6))

     (fun))

   (lambda errors
     (set! threw? #t)))

  (unless threw?
    (display "ERROR: expected an exception saying that called once context was not initialized")
    (newline)
    (exit 1)))


(let ()
  (with-called-once-extent

   (define threw? #f)

   (catch-any
    (lambda _
      (define (fun)
        (assert-called-once)
        (+ 3 6))

      (fun)
      (fun)
      (fun)
      (fun))

    (lambda errors
      (set! threw? #t)))

   (unless threw?
     (display "ERROR: expected an exception about multiple calls")
     (newline)
     (exit 1))))
