
%run guile

;; Returns leftmost extension with a dot or ""
%var path-extensions

(define (path-extensions str)
  (let ((index (string-index str #\.)))
    (if index (string-drop str index) "")))
