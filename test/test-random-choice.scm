
(cond-expand
 (guile
  (define-module (test-random-choice)
    :use-module ((euphrates assert) :select (assert))
    :use-module ((euphrates printable-alphabet) :select (printable/alphabet))
    :use-module ((euphrates random-choice) :select (random-choice)))))


(let () ;; random-choice
  (assert (equal? 5 (string-length (list->string (random-choice 5 printable/alphabet))))))
