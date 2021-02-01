
%run guile

%use (random-choice) "./random-choice.scm"
%use (alphanum/alphabet) "./alphanum-alphabet.scm"

%var make-temporary-filename

(define (make-temporary-filename)
  (let* ((s (list->string (random-choice 10 alphanum/alphabet))))
    (string-append "/tmp/euphrates-temp-" s)))
