

;; Returns extension with a dot or ""

(define (path-extension str)
  (let ((index (string-index-right str #\.)))
    (if index
        (let ((ext (string-drop str index)))
          (if (< 1 (string-length ext)) ext ""))
        "")))
