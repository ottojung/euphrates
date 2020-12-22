
%run guile

%var path-without-extension

(define (path-without-extension str)
  (let ((index (string-index-right str #\.)))
    (string-take str index)))

