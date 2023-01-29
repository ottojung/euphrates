
%run guile

%var file-or-directory-exists?

%for (COMPILER "guile")

(define file-or-directory-exists? file-exists?)

%end

%for (COMPILER "racket")

(define [file-or-directory-exists? path]
  (or (file-exists? path)
      (directory-exists? path)))

%end

