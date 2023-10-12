
(define (~s x)
  (cond
   ((number? x) (number->string x))
   ((symbol? x) (symbol->string x))
   (else
    (call-with-output-string
     (lambda (port)
       (write x port))))))
