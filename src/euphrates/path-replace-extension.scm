



(define (path-replace-extension str new-ext)
  (let ((stripped (path-without-extension str)))
    (string-append stripped new-ext)))
