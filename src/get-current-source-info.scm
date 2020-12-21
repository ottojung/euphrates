
%run guile

%var get-current-source-info

%for (COMPILER "guile")

(define-syntax-rule [get-current-source-info]
  (current-source-location))

%end

