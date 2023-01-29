
(cond-expand
 (guile
  (define-module (euphrates assert-raw)
    :export (#{assert#raw}#)
    :use-module ((euphrates raisu) :select (raisu)))))



(define-syntax assert#raw
  (syntax-rules ()
    ((_ test)
     (unless test
       (raisu 'assertion-fail
              `(test: ,(quote test)))))
    ((_ test . printf-args)
     (unless test
       (raisu 'assertion-fail
              `(test: ,(quote test))
              `(description: ,(stringf . printf-args)))))))


