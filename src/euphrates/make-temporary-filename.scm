
(cond-expand
 (guile
  (define-module (euphrates make-temporary-filename)
    :export (make-temporary-filename)
    :use-module ((euphrates random-choice) :select (random-choice))
    :use-module ((euphrates alphanum-alphabet) :select (alphanum/alphabet)))))



(define (make-temporary-filename)
  (let* ((s (list->string (random-choice 10 alphanum/alphabet))))
    (string-append "/tmp/euphrates-temp-" s)))
