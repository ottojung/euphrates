
%run guile

%var file-mtime

%for (COMPILER "guile")

(define [file-mtime filepath]
  (stat:mtime (stat filepath)))

%end

