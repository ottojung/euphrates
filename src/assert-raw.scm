
%run guile

%var assert#raw

(define-syntax assert#raw
  (syntax-rules ()
    ((_ test)
     (unless test
       (throw 'assertion-fail
              `(test: ,(quote test)))))
    ((_ test . printf-args)
     (unless test
       (throw 'assertion-fail
              `(test: ,(quote test))
              `(description: ,(stringf . printf-args)))))))

