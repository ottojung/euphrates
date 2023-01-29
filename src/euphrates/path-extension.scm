
%run guile

;; Returns extension with a dot or ""
%var path-extension

(define (path-extension str)
  (let ((index (string-index-right str #\.)))
    (if index
        (let ((ext (string-drop str index)))
          (if (< 1 (string-length ext)) ext ""))
        "")))
