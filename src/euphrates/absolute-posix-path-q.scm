
%run guile

%var absolute-posix-path?

(define (absolute-posix-path? path)
  (and (string? path)
       (> (string-length path) 0)
       (char=? (string-ref path 0) #\/)))

