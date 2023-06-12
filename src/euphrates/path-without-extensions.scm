


(define (path-without-extensions str)
  (let ((index (string-index str #\.)))
    (if index (string-take str index) str)))
