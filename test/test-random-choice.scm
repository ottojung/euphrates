


(let () ;; random-choice
  (assert (equal? 5 (string-length (list->string (random-choice 5 printable/alphabet))))))
