
%run guile

%var define-tuple

(define-syntax define-tuple
  (syntax-rules ()
    ((_ () value)
     (begin value (values)))
    ((_ (v . vs) value)
     (define-values (v . vs)
       (apply values value)))
    ((_ single value)
     (define single value))))
