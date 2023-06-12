
(define (get-directory-name path)
  (define (root? path)
    (string-every
     (lambda (c) (equal? #\/ c)) path))

  (cond
   ((string-null? path) ".")
   ((root? path) "/")
   (else
    (let* ((trimmed (string-trim-right path #\/))
           (ri (string-index-right trimmed #\/)))
      (if ri
          (let ((sub (substring trimmed 0 ri)))
            (if (root? sub) "/"
                (string-trim-right sub #\/)))
          ".")))))
