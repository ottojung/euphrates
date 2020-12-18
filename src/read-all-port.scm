
%run guile

%var read-all-port

;; `readf' is usually `read-char' or `read-byte'
(define read-all-port
  (case-lambda
   ((readf port)
    (let loop ((result '()) (chr (readf port)))
      (if (eof-object? chr)
          (list->string (reverse result))
          (loop (cons chr result) (readf port)))))
   ((port)
    (read-all-port read-char port))))
