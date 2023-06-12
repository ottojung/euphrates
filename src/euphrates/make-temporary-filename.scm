



(define (make-temporary-filename)
  (let* ((s (list->string (random-choice 10 alphanum/alphabet))))
    (string-append "/tmp/euphrates-temp-" s)))
