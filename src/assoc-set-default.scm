
%run guile

%var assoc-set-default

(define (assoc-set-default key value alist)
  (define got (assoc key alist))
  (define current (and got (cdr got)))
  (if current alist (assoc-set-value key value alist)))
