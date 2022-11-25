
%run guile

%var assq-or

(define-syntax assq-or
  (syntax-rules ()
    ((_ key alist)
     (assq-or key alist #f))
    ((_ key alist default)
     (let ((got (assq key alist)))
       (if got (cdr got)
           default)))))
