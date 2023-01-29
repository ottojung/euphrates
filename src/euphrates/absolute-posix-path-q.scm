
(cond-expand
 (guile
  (define-module (euphrates absolute-posix-path-q)
    :export (absolute-posix-path?))))


(define (absolute-posix-path? path)
  (and (string? path)
       (> (string-length path) 0)
       (char=? (string-ref path 0) #\/)))

