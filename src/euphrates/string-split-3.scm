
(cond-expand
 (guile
  (define-module (euphrates string-split-3)
    :export (string-split-3)
    :use-module ((euphrates list-prefix-q) :select (list-prefix?))
    :use-module ((euphrates list-drop-n) :select (list-drop-n))
    :use-module ((euphrates raisu) :select (raisu)))))



(define (string-split-3 delimiter str)
  (define (string-split-first/lambda predicate str)
    (define lst (string->list str))
    (let loop ((buf lst) (ret '()))
      (if (null? buf) (values str "" "")
          (let ((cur (car buf)))
            (if (predicate cur)
                (values (list->string (reverse ret))
                        (list->string (list cur))
                        (list->string (cdr buf)))
                (loop (cdr buf) (cons cur ret)))))))

  (define (string-split-first/string delimiter str)
    (define lst (string->list str))
    (define len (length delimiter))
    (let loop ((buf lst) (ret '()))
      (if (null? buf) (values str "" "")
          (if (list-prefix? delimiter buf)
              (values (list->string (reverse ret))
                      (list->string delimiter)
                      (list->string (list-drop-n len buf)))
              (loop (cdr buf) (cons (car buf) ret))))))

  (cond
   ((string? delimiter) (string-split-first/string (string->list delimiter) str))
   ((char? delimiter) (string-split-first/string (list delimiter) str))
   ((procedure? delimiter) (string-split-first/lambda delimiter str))
   (else (raisu 'delimiter-must-be-string-or-char-or-procedure delimiter))))
