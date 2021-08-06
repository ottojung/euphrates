
%run guile

;; Uses single quotes, and puts single quotes into double quotes,
;; so the string $'b is quoted as '$'"'"'b'
%var shell-quote

(define (shell-quote str)
  (define lst (string->list str))

  (define escaped/reversed
    (cons #\'
          (let loop ((lst lst))
            (if (null? lst)
                '(#\')
                (let ((x (car lst)))
                  (if (equal? #\' x)
                      (cons #\' (cons #\" (cons #\' (cons #\" (cons #\' (loop (cdr lst)))))))
                      (cons x (loop (cdr lst)))))))))

  (list->string escaped/reversed))

