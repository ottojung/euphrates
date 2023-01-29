
%run guile

;; Returns leftmost extension with a dot or ""
;; Only returns "meaningful" extensions
%var path-extensions

%use (path-get-basename) "./path-get-basename.scm"
%use (alphanum/alphabet/index) "./alphanum-alphabet.scm"
%use (list-and-map) "./list-and-map.scm"
%use (string-split/simple) "./string-split-simple.scm"

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
