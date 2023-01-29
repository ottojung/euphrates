
%run guile

;;
;; @returns #f on success, #t on failure
%var file-delete

%use (catch-any) "./catch-any.scm"

%for (COMPILER "guile")

(define (file-delete filepath)
  (catch-any
   (lambda _
     (delete-file filepath)
     #f)
   (lambda _
     #t)))

%end
