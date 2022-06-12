
%run guile

;; Returns leftmost extension with a dot or ""
%var path-extensions

%use (path-get-basename) "./path-get-basename.scm"

(define (path-extensions str)
  (define basename (path-get-basename str))
  (let ((index (string-index basename #\.)))
    (if index (string-drop basename index) "")))
