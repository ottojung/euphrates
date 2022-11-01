
%run guile

%use (assert) "./src/assert.scm"
%use (printable/alphabet) "./src/printable-alphabet.scm"
%use (random-choice) "./src/random-choice.scm"

(let () ;; random-choice
  (assert (equal? 5 (string-length (list->string (random-choice 5 printable/alphabet))))))
