
(cond-expand
 (guile
  (define-module (euphrates string-null-or-whitespace-p)
    :export (string-null-or-whitespace?))))


(define (string-null-or-whitespace? str)
  (let loop ((i (- (string-length str) 1)))
    (if (< i 0) #t
        (case (string-ref str i) ;; TODO: is this O(1)?
          ((#\space #\tab #\newline) (loop (- i 1)))
          (else #f)))))
