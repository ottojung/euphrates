
%run guile

%var read-string-line

%for (COMPILER "guile")

(use-modules (ice-9 textual-ports))

(define read-string-line
  (case-lambda
   (() (read-string-line (current-input-port)))
   ((port)
    (list->string
    (let loop ((buf '()))
      (let ((c (get-char port)))
        (if (or (eof-object? c)
                (equal? #\newline c))
            (reverse buf)
            (loop (cons c buf)))))))))

%end
