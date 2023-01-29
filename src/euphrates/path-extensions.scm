
(cond-expand
 (guile
  (define-module (euphrates path-extensions)
    :export (path-extensions)
    :use-module ((euphrates path-get-basename) :select (path-get-basename))
    :use-module ((euphrates alphanum-alphabet) :select (alphanum/alphabet/index))
    :use-module ((euphrates list-and-map) :select (list-and-map))
    :use-module ((euphrates string-split-simple) :select (string-split/simple)))))

;; Returns leftmost extension with a dot or ""
;; Only returns "meaningful" extensions


(define (path-extensions str)
  (define parts
    (reverse (string-split/simple str #\.)))
  (let loop ((parts parts) (buf ""))
    (if (or (null? parts)
            (null? (cdr parts)))
        buf
        (let* ((s (car parts))
               (L (string->list s)))
          (cond
           ((null? L) buf)
           ((list-and-map alphanum/alphabet/index L)
            (loop (cdr parts) (string-append "." s buf)))
           (else buf))))))
