
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
