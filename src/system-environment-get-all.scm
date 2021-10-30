
%run guile

%var system-environment-get-all

%use (string-split/simple) "./string-split-simple.scm"
%use (string-drop-n) "./string-drop-n.scm"

%for (COMPILER "guile")

(define (system-environment-get-all)
  (define vars (environ))
  (define (split v)
    (define parts (string-split/simple v #\=))
    (define head (car parts))
    (define tail (string-drop-n (+ (string-length head) 1) v))
    (cons head tail))
  (map split vars))

%end
