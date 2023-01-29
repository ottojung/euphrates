
(cond-expand
 (guile
  (define-module (euphrates get-command-line-arguments)
    :export (get-command-line-arguments)
    :use-module ((euphrates command-line-arguments-p) :select (command-line-argumets/p)))))



(define get-command-line-arguments
  (let ((default
          (lambda _

        (cond-expand
         (guile
              (let ((ret (command-line)))
        (if (< (length ret) 2)
                    '()
                    (cdr ret))))
         ))
      (cond-expand
       (racket
            (vector->list
             (current-command-line-arguments)))
       ))
        ))

  (lambda _
    (or (command-line-argumets/p)
        (default)))))
