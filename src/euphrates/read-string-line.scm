
(cond-expand
 (guile
  (define-module (euphrates read-string-line)
    :export (read-string-line))))


(cond-expand
 (guile

  (use-modules (ice-9 textual-ports))

  (define read-string-line
    (case-lambda
     (() (read-string-line (current-input-port)))
     ((port)
      (let loop ((buf '()))
    (let ((c (get-char port)))
          (cond
           ((eof-object? c)
            (if (null? buf) c
        (list->string (reverse buf))))
           ((equal? #\newline c)
            (list->string (reverse buf)))
           (else (loop (cons c buf)))))))))

  ))
