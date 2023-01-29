
(cond-expand
 (guile
  (define-module (euphrates make-directories)
    :export (make-directories)
    :use-module ((euphrates string-split-simple) :select (string-split/simple))
    :use-module ((euphrates list-fold) :select (list-fold))
    :use-module ((euphrates file-or-directory-exists-q) :select (file-or-directory-exists?))
    :use-module ((euphrates append-posix-path) :select (append-posix-path))
    :use-module ((euphrates string-null-or-whitespace-p) :select (string-null-or-whitespace?)))))



(define (make-directories path)

  (cond-expand
   (guile
    (define mk-single-dir mkdir)
    )
   (racket
    (define mk-single-dir make-directory)
    ))

  (define parts (string-split/simple path #\/))
  (list-fold
   (acc #f)
   (i parts)
   (let* ((path0 (if acc (append-posix-path acc i) i))
          (path (if (string-null? path0) "/" path0)))
     (unless (file-or-directory-exists? path)
       (mk-single-dir path))
     path)))
