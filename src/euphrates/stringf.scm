
(cond-expand
 (guile
  (define-module (euphrates stringf)
    :export (stringf)
    :use-module ((euphrates printf) :select (printf)))))



(define (stringf fmt . args)
  (with-output-to-string
    (lambda []
      (apply printf (cons fmt args)))))
