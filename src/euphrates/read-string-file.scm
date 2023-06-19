
(define (read-string-file path)
  (call-with-output-string
   (lambda (s)
     (call-with-input-file
         path
       (lambda (p)
         (let loop ()
           (define r (read-string 4096 p))
           (unless (eof-object? r)
             (display r s))))))))
