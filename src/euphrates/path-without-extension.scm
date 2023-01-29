
(cond-expand
 (guile
  (define-module (euphrates path-without-extension)
    :export (path-without-extension))))


(define (path-without-extension str)
  (let ((index (string-index-right str #\.)))
    (if index (string-take str index) str)))

