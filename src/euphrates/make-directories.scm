



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
