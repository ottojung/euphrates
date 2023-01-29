
(cond-expand
 (guile
  (define-module (euphrates directory-tree)
    :export (directory-tree))))


;; Returns object like this:
;;  '((dir1 (dir1/file1 dir1/file2))
;;    (dir2)
;;    (dir3 (dir3/dir2 ..

(cond-expand
 (guile

  (use-modules (ice-9 ftw))

  (define [directory-tree directory]
    (define (remove-stat args)
      (let ((name (car args))
            (children (cddr args)))
    (if (null? children) name
            (cons name (map remove-stat children)))))
    (remove-stat (file-system-tree directory)))

  ))


