
%run guile

%use (string-split/simple) "./string-split-simple.scm"
%use (list-fold) "./list-fold.scm"
%use (file-or-directory-exists?) "./file-or-directory-exists-q.scm"
%use (append-posix-path) "./append-posix-path.scm"

%var make-directory

%for (COMPILER "guile")

(define (make-directories path)
  (define parts (string-split/simple path #\/))
  (list-fold
   (acc #f)
   (i parts)
   (let* ((path (if acc (append-posix-path acc i) i)))
     (unless (file-or-directory-exists? path)
       (mkdir path))
     path)))

%end
%for (COMPILER "racket")

(define (make-directories path)
  (define parts (string-split/simple path #\/))
  (list-fold
   (acc #f)
   (i parts)
   (let* ((path (if acc (append-posix-path acc i) i)))
     (unless (file-or-directory-exists? path)
       (make-directory path))
     path)))

%end
