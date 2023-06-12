


(cond-expand
 (guile

  (define (un~s str)
    (call-with-input-string
     str (lambda (port)
           (let ((ret (read port)))
             (close-port port)
             ret))))

  ))
