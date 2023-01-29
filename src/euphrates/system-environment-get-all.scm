
(cond-expand
 (guile
  (define-module (euphrates system-environment-get-all)
    :export (system-environment-get-all)
    :use-module ((euphrates string-split-simple) :select (string-split/simple))
    :use-module ((euphrates string-drop-n) :select (string-drop-n)))))



(cond-expand
 (guile

  (define (system-environment-get-all)
    (define vars (environ))
    (define (split v)
      (define parts (string-split/simple v #\=))
      (define head (car parts))
      (define tail (string-drop-n (+ (string-length head) 1) v))
      (cons head tail))
    (map split vars))

  ))
