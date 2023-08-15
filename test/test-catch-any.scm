
(catch-any
 (lambda _ (generic-error `((key1 . val1))))
 (lambda _ 'good))

(let ((threw? #f))
  (catch-any
   (lambda _ (generic-error `((key1 . val1))))
   (lambda _ (set! threw? #t)))

  (unless threw?
    (display "Expected error, but got nothing." (current-error-port))
    (newline (current-error-port))
    (exit 1)))

(catch-any
 (lambda _ (+ 1 2))
 (lambda errs
   (display "Unexpected error: " (current-error-port))
   (write errs (current-error-port))
   (newline (current-error-port))
   (exit 1)))

(catch-any
 (lambda _ (+ 1 2))
 (lambda errs
   (display "Unexpected error: " (current-error-port))
   (write errs (current-error-port))
   (newline (current-error-port))
   (exit 1)))

(let ((threw? #f))
  (catch-any
   (lambda _ (generic-error `((key1 . val1))))
   (lambda err-resp
     (unless (= 1 (length err-resp))
       (display "Expected a single error to be returned to the handled, but got a different amount: " (current-error-port))
       (write err-resp (current-error-port))
       (newline (current-error-port)))

     (define err (car err-resp))

     (unless (generic-error? err)
       (display "Expected generic-error, but got something else." (current-error-port))
       (newline (current-error-port)))

     (set! threw? #t)))

  (unless threw?
    (display "Expected error, but got nothing." (current-error-port))
    (newline (current-error-port))
    (exit 1)))
