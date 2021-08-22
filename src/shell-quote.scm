
%run guile

;; Uses single quotes, and puts single quotes into double quotes,
;; so the string $'b is quoted as '$'"'"'b'
%var shell-quote

%use (alphanum/alphabet/index) "./alpha-alphabet.scm"

(define (shell-quote str)
  (define lst (string->list str))

  (if (null? (filter (negate alphanum/alphabet/index) lst))
      str
      (list->string
       (cons #\'
             (let loop ((lst lst))
               (if (null? lst)
                   '(#\')
                   (let ((x (car lst)))
                     (if (equal? #\' x)
                         (cons #\' (cons #\" (cons #\' (cons #\" (cons #\' (loop (cdr lst)))))))
                         (cons x (loop (cdr lst)))))))))))

