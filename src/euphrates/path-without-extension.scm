


(define (path-without-extension str)
  (let ((index (string-index-right str #\.)))
    (if index (string-take str index) str)))

