
(cond-expand
 (guile
  (define-module (euphrates assoc-or)
    :export (assoc-or))))


(define-syntax assoc-or
  (syntax-rules ()
    ((_ key alist default)
     (let ((got (assoc key alist)))
       (if got (cdr got)
           default)))
    ((_ key alist)
     (let ((got (assoc key alist)))
       (and got (cdr got))))))
