
(cond-expand
 (guile
  (define-module (euphrates un-tilda-s)
    :export (un~s))))


(cond-expand
 (guile

  (define (un~s str)
    (call-with-input-string
     str (lambda (port)
           (let ((ret (read port)))
             (close-port port)
             ret))))

  ))
