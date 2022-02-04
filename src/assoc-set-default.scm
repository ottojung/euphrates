
%run guile

%var assoc-set-default

%use (assoc-set-value) "./assoc-set-value.scm"

(define (assoc-set-default key value alist)
  (define got (assoc key alist))
  (define current (and got (cdr got)))
  (if current alist (assoc-set-value key value alist)))
