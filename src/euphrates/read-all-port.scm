
(cond-expand
 (guile
  (define-module (euphrates read-all-port)
    :export (read-all-port))))


;; `readf' is usually `read-char' or `read-byte'
(define read-all-port
  (case-lambda
   ((port)
    (read-all-port port read-char))
   ((port readf)
    (read-all-port port readf list->string))
   ((port readf collect)
    (let loop ((result '()) (chr (readf port)))
      (if (eof-object? chr)
          (collect (reverse result))
          (loop (cons chr result) (readf port)))))))
