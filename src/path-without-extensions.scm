
%run guile

%var path-without-extensions

(define (path-without-extensions str)
  (let ((index (string-index-left str #\.)))
    (if index (string-take str index) str)))
