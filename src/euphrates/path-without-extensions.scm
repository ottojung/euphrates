
(cond-expand
 (guile
  (define-module (euphrates path-without-extensions)
    :export (path-without-extensions))))


(define (path-without-extensions str)
  (let ((index (string-index str #\.)))
    (if index (string-take str index) str)))
