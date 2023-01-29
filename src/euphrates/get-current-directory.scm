
%run guile

%var get-current-directory

%use (current-directory/p) "./current-directory-p.scm"

%for (COMPILER "guile")

(define get-process-global-current-directory getcwd)

%end

%for (COMPILER "racket")

(define (get-process-global-current-directory)
  (path->string (current-directory)))

%end

(define (get-current-directory)
  (or (current-directory/p)
      (let ((cwd (get-process-global-current-directory)))
        (current-directory/p cwd)
        cwd)))
