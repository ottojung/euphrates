
%run guile

%use (assert) "./euphrates/assert.scm"
%use (printable/alphabet) "./euphrates/printable-alphabet.scm"
%use (random-choice) "./euphrates/random-choice.scm"

(let () ;; random-choice
  (assert (equal? 5 (string-length (list->string (random-choice 5 printable/alphabet))))))
