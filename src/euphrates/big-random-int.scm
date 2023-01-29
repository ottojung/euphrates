
(cond-expand
 (guile
  (define-module (euphrates big-random-int)
    :export (big-random-int)
    :use-module ((euphrates get-current-random-source) :select (get-current-random-source))
    :use-module ((euphrates srfi-27-generic) :select (random-source-make-integers)))))



(define big-random-int
  (lambda (max)
    ((random-source-make-integers
      (get-current-random-source)) max)))
