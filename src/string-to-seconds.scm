
%run guile

;; accepts format like "2h30m" or "30m2h" or "2h20s3m"
%var string->seconds

%use (raisu) "./raisu.scm"

(define (string->seconds s)
  (define lst (string->list s))
  (let loop ((lst lst) (buf '()))
    (if (null? lst) 0
        (let ((x (car lst)))
          (case x
            ((#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9)
             (loop (cdr lst) (cons x buf)))
            (else
             (let* ((last-number (string->number (list->string (reverse buf)))))
               (case x
                 ((#\s) (+ (* last-number 1) (loop (cdr lst) '())))
                 ((#\m) (+ (* last-number 60) (loop (cdr lst) '())))
                 ((#\h) (+ (* last-number 60 60) (loop (cdr lst) '())))
                 (else (raisu 'bad-format-for-string->seconds s))))))))))
