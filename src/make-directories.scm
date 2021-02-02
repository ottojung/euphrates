
%run guile

%use (string-split/simple) "./string-split-simple.scm"
%use (list-fold) "./list-fold.scm"
%use (file-or-directory-exists?) "./file-or-directory-exists-q.scm"
%use (append-posix-path) "./append-posix-path.scm"
%use (string-null-or-whitespace?) "./string-null-or-whitespace-p.scm"

%var make-directories

(define (make-directories path)

%for (COMPILER "guile")
  (define mk-single-dir mkdir)
%end
%for (COMPILER "racket")
  (define mk-single-dir make-directory)
%end

  (define parts (string-split/simple path #\/))
  (list-fold
   (acc #f)
   (i parts)
   (let* ((path0 (if acc (append-posix-path acc i) i))
          (path (if (string-null? path0) "/" path0)))
     (unless (file-or-directory-exists? path)
       (mk-single-dir path))
     path)))
