
%run guile

%var file-delete

%for (COMPILER "guile")

(define file-delete delete-file)

%end
