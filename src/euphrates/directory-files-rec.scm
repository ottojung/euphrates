
(cond-expand
 (guile
  (define-module (euphrates directory-files-rec)
    :export (directory-files-rec)
    :use-module ((euphrates directory-files-depth-iter) :select (directory-files-depth-iter)))))


;; Returns object like this:
;;    ((fullname name dirname1 dirname2 dirname3...
;;     (fullname name ....
;;
;;  where dirname1 is the parent dir of the file


(cond-expand
 (guile

  (define directory-files-rec
    (case-lambda
     ((directory) (directory-files-rec #f directory))
     ((include-directories? directory)
      (define iter
    (directory-files-depth-iter include-directories? +inf.0 directory))

      (let loop ((buf '()))
    (define x (iter))
    (if x
            (loop (cons x buf))
            buf)))))

  )

 (racket

  (define [directory-files-rec directory]
    (define (tostring path)
      (case path
    ((same) directory)
    (else (path->string path))))

    (fold-files
     (lambda [f type ctx]
       (cons (map tostring
                  (cons f (reverse (explode-path f))))
             ctx))
     '()
     directory))

  ))
