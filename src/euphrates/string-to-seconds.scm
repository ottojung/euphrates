

;; accepts format like "2h30m" or "30m2h" or "2h20s3m" or "2.5h20s3m"


(define (string->seconds s)
  (define lst (string->list s))
  (define (get-last-number buf)
    (string->number (list->string (reverse buf))))

  (let loop ((lst lst) (buf '()))
    (if (null? lst)
        (if (null? buf) 0
            (get-last-number buf))
        (let ((x (car lst)))
          (case x
            ((#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 #\.)
             (loop (cdr lst) (cons x buf)))
            (else
             (let* ((last-number (get-last-number buf)))
               (or
                (and
                 last-number
                 (case x
                   ((#\s) (+ (* last-number 1) (loop (cdr lst) '())))
                   ((#\m) (+ (* last-number 1 60) (loop (cdr lst) '())))
                   ((#\h) (+ (* last-number 1 60 60) (loop (cdr lst) '())))
                   ((#\d) (+ (* last-number 1 60 60 24) (loop (cdr lst) '())))
                   ((#\w) (+ (* last-number 1 60 60 24 7) (loop (cdr lst) '())))
                   (else #f)))
                (raisu 'bad-format-for-string->seconds s)))))))))
