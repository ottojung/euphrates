
%run guile

%var file-delete

%use (with-ignore-errors!) "./with-ignore-errors.scm"

%for (COMPILER "guile")

(define (file-delete filepath)
  (with-ignore-errors! (delete-file filepath)))

%end
