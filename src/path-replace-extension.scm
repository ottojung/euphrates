
%run guile

%use (path-without-extension) "./path-without-extension.scm"

%var path-replace-extension

(define (path-replace-extension str new-ext)
  (let ((stripped (path-without-extension str)))
    (string-append stripped new-ext)))
