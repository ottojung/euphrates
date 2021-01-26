
%run guile

%use (command-line-argumets/p) "./command-line-arguments-p.scm"

%var get-command-line-arguments

(define get-command-line-arguments
  (let default
      (lambda _

%for (COMPILER "guile")
        (let ((ret (command-line)))
          (if (< (length ret) 2)
              '()
              (cdr ret))))
%end
%for (COMPILER "racket")
        (vector->list
         (current-command-line-arguments)))
%end

   (lambda _
     (or (command-line-argumets/p)
         (default))))
