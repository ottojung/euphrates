

(cond-expand
 (guile
  (define (make-temporary-fileport)
    (let ((port (mkstemp! (string-copy "/tmp/myfile-XXXXXX"))))
      (chmod port (logand #o666 (lognot (umask))))
      (values port (port-filename port))))))

