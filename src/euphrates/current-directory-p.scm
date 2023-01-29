
(cond-expand
 (guile
  (define-module (euphrates current-directory-p)
    :export (current-directory/p))))


(define current-directory/p
  (make-parameter #f))
