
(cond-expand
 (guile
  (define-module (euphrates file-delete)
    :export (file-delete)
    :use-module ((euphrates catch-any) :select (catch-any)))))

;;
;; @returns #f on success, #t on failure


(cond-expand
 (guile

  (define (file-delete filepath)
    (catch-any
     (lambda _
       (delete-file filepath)
       #f)
     (lambda _
       #t)))

  ))
