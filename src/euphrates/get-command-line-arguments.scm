



(define get-command-line-arguments
  (let ((default
          (lambda _
            (cond-expand
             (guile
              (let ((ret (command-line)))
                (if (< (length ret) 2)
                    '()
                    (cdr ret))))
             (racket
              (vector->list
               (current-command-line-arguments)))))))

    (lambda _
      (or (command-line-argumets/p)
          (default)))))
