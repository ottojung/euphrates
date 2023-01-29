
(cond-expand
 (guile
  (define-module (euphrates path-replace-extension)
    :export (path-replace-extension)
    :use-module ((euphrates path-without-extension) :select (path-without-extension)))))



(define (path-replace-extension str new-ext)
  (let ((stripped (path-without-extension str)))
    (string-append stripped new-ext)))
